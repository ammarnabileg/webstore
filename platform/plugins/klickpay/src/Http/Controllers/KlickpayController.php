<?php

namespace Botble\Klickpay\Http\Controllers;

use Botble\Base\Http\Controllers\BaseController;
use Botble\Base\Http\Responses\BaseHttpResponse;
use Botble\Ecommerce\Models\Customer;
use Botble\Ecommerce\Models\Order;
use Botble\Klickpay\Services\Gateways\KlickpayPaymentService;
use Botble\Payment\Enums\PaymentStatusEnum;
use Botble\Payment\Models\Payment;
use Botble\Payment\Supports\PaymentHelper;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;

class KlickpayController extends BaseController
{
    protected const PAID_STATUSES = ['paid', 'success', 'completed', 'captured'];

    /**
     * Customer is redirected here from KlickPay. The query string is user-controlled, so the
     * payment is only confirmed after asking KlickPay about the payment id we stored ourselves.
     */
    public function status(Request $request, BaseHttpResponse $response, KlickpayPaymentService $klickpayService)
    {
        // Looked up by the unguessable checkout token from our own return URL; a numeric
        // order id would let anyone walk order ids and open other customers' order pages.
        $order = $request->filled('t') ? Order::query()->where('token', (string) $request->input('t'))->first() : null;

        if (! $order) {
            return $response
                ->setError()
                ->setNextUrl(PaymentHelper::getCancelURL())
                ->setMessage(__('Payment failed or invalid order.'));
        }

        if ($request->input('status') !== 'success') {
            return $response
                ->setError()
                ->setNextUrl(PaymentHelper::getCancelURL($order->token))
                ->setMessage(__('Payment was cancelled or failed.'));
        }

        // Only a payment id created by our own checkout request is trusted, never one from the URL.
        $paymentId = session('klickpay_payment_id_' . $order->getKey())
            ?: Cache::get('klickpay_payment_id_' . $order->getKey());

        if ($paymentId) {
            $statusData = $klickpayService->getPaymentStatus($paymentId) ?? [];
            $apiStatus = strtolower((string) Arr::get($statusData, 'data.status'));

            if (! in_array($apiStatus, self::PAID_STATUSES, true)) {
                return $response
                    ->setError()
                    ->setNextUrl(PaymentHelper::getCancelURL($order->token))
                    ->setMessage(__('Payment was cancelled or failed.'));
            }

            $apiAmount = Arr::get($statusData, 'data.transction_amount', Arr::get($statusData, 'data.amount'));

            if ($apiAmount !== null && ! $this->amountMatches($order, $apiAmount)) {
                Log::warning('KlickPay status: amount mismatch', ['order_id' => $order->getKey(), 'payment_id' => $paymentId]);

                return $response
                    ->setError()
                    ->setNextUrl(PaymentHelper::getCancelURL($order->token))
                    ->setMessage(__('Payment could not be verified. Please contact us.'));
            }

            $this->markPaid($order, (string) $paymentId);
        }

        // Without a stored payment id (e.g. finished on another device) the signed webhook confirms it.
        return $response
            ->setNextUrl(PaymentHelper::getRedirectURL($order->token))
            ->setMessage(__('Payment processed successfully.'));
    }

    public function webhook(Request $request)
    {
        $rawBody = $request->getContent();
        $signature = (string) $request->header('X-KlickPay-Signature');

        $secret = get_payment_setting('webhook_secret', 'klickpay');

        if (empty($secret)) {
            Log::error('KlickPay webhook: secret not configured.');

            return response()->json(['error' => 'Webhook not configured'], 500);
        }

        if (! hash_equals(hash_hmac('sha256', $rawBody, $secret), $signature)) {
            // Never log the expected signature: it would let anyone with log access forge webhooks.
            Log::warning('KlickPay webhook: signature mismatch.');

            return response()->json(['error' => 'Signature mismatch'], 401);
        }

        $payload = json_decode($rawBody, true) ?: [];
        $eventType = $payload['event_type'] ?? $request->header('X-KlickPay-Event');

        Log::info('KlickPay webhook received', ['event' => $eventType, 'payment_id' => $payload['payment_id'] ?? null]);

        if ($eventType !== 'payment.success') {
            return response('OK', 200);
        }

        $orderId = $this->orderIdFromReference($payload['transction_reference'] ?? null);
        $paymentId = $payload['payment_id'] ?? null;
        $order = $orderId ? Order::query()->find($orderId) : null;

        if (! $order || ! $paymentId) {
            Log::warning('KlickPay webhook: unknown order', ['reference' => $payload['transction_reference'] ?? null]);

            return response()->json(['error' => 'Order not found'], 404);
        }

        if (! $this->amountMatches($order, $payload['transction_amount'] ?? null)) {
            Log::warning('KlickPay webhook: amount mismatch', ['order_id' => $order->getKey(), 'payment_id' => $paymentId]);

            return response()->json(['error' => 'Amount mismatch'], 422);
        }

        $this->markPaid($order, (string) $paymentId);

        return response('OK', 200);
    }

    /**
     * Idempotent: the return page and the webhook can both arrive; the order is processed once.
     */
    protected function markPaid(Order $order, string $chargeId): void
    {
        Cache::lock('klickpay_process_' . $order->getKey(), 10)->block(5, function () use ($order, $chargeId): void {
            $alreadyPaid = Payment::query()
                ->where('order_id', $order->getKey())
                ->where('charge_id', $chargeId)
                // Any status: a replayed success webhook must not re-open a refunded payment.
                ->exists();

            if ($alreadyPaid) {
                return;
            }

            do_action(PAYMENT_ACTION_PAYMENT_PROCESSED, [
                'amount' => $order->amount,
                'currency' => 'KWD',
                'charge_id' => $chargeId,
                'payment_channel' => 'klickpay',
                'status' => PaymentStatusEnum::COMPLETED,
                'customer_id' => $order->user_id ?: null,
                'customer_type' => Customer::class,
                'payment_type' => 'direct',
                'order_id' => [$order->getKey()],
            ]);
        });
    }

    protected function orderIdFromReference(mixed $reference): ?int
    {
        // Checkout sends "ORD-{order id}" as transction_reference.
        if (! is_scalar($reference) || ! preg_match('/^(?:ORD-)?(\d+)$/', (string) $reference, $m)) {
            return null;
        }

        return (int) $m[1];
    }

    protected function amountMatches(Order $order, mixed $amount): bool
    {
        if (! is_numeric(str_replace(',', '', (string) $amount))) {
            return false;
        }

        return abs((float) str_replace(',', '', (string) $amount) - (float) $order->amount) < 0.001;
    }
}
