<?php

namespace Botble\Taly\Http\Controllers;

use Botble\Base\Http\Controllers\BaseController;
use Botble\Base\Http\Responses\BaseHttpResponse;
use Botble\Ecommerce\Models\Customer;
use Botble\Ecommerce\Models\Order;
use Botble\Payment\Enums\PaymentStatusEnum;
use Botble\Payment\Models\Payment;
use Botble\Payment\Supports\PaymentHelper;
use Botble\Taly\Services\Gateways\TalyPaymentService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;

class TalyController extends BaseController
{
    /**
     * Customer returns from Taly. The URL proves nothing, so this page never marks the order
     * paid: the signed postBack webhook does. We only send the customer to the right page.
     */
    public function getPaymentStatus(Request $request, BaseHttpResponse $response)
    {
        // Looked up by the unguessable checkout token from our own return URL (never the id).
        $order = $request->filled('t') ? Order::query()->where('token', (string) $request->input('t'))->first() : null;
        $token = $order?->token;

        if (! $order || $request->input('result') !== 'success') {
            return $response
                ->setError()
                ->setNextUrl(PaymentHelper::getCancelURL($token))
                ->setMessage(__('Payment failed or cancelled.'));
        }

        return $response
            ->setNextUrl(PaymentHelper::getRedirectURL($token))
            ->setMessage(__('Your payment is being confirmed. You will be notified once it is approved.'));
    }

    public function postWebhook(Request $request, TalyPaymentService $talyService)
    {
        // Body only: input() would merge query-string parameters into the signed payload.
        $payload = $request->isJson() ? $request->json()->all() : $request->post();
        if (! $payload && $request->getContent() !== '') {
            // Callbacks sent without a JSON Content-Type still carry a JSON body.
            $decoded = json_decode($request->getContent(), true);
            $payload = is_array($decoded) ? $decoded : [];
        }
        $signature = (string) $request->header('Taly-Signature');

        if ($signature === '' || ! $talyService->verifySignature($payload, $signature)) {
            Log::warning('Taly webhook: invalid signature', ['merchantOrderId' => $payload['merchantOrderId'] ?? null]);

            return response()->json(['message' => 'Invalid signature'], 403);
        }

        $orderStatus = strtoupper((string) ($payload['orderStatus'] ?? ''));
        $order = Order::query()->find((int) ($payload['merchantOrderId'] ?? 0));
        $chargeId = (string) ($payload['orderToken'] ?? $payload['orderId'] ?? '');

        if (! $order || $chargeId === '') {
            Log::warning('Taly webhook: order not found', ['merchantOrderId' => $payload['merchantOrderId'] ?? null]);

            return response()->json(['message' => 'Order not found'], 404);
        }

        if (in_array($orderStatus, ['CONFIRMED', 'PAID'], true)) {
            $amount = $payload['amount'] ?? null;

            if (! is_numeric($amount) || abs((float) $amount - (float) $order->amount) >= 0.001) {
                Log::warning('Taly webhook: amount mismatch', ['order_id' => $order->getKey()]);

                return response()->json(['message' => 'Amount mismatch'], 422);
            }

            Cache::lock('taly_process_' . $order->getKey(), 10)->block(5, function () use ($order, $chargeId): void {
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
                    'payment_channel' => 'taly',
                    'status' => PaymentStatusEnum::COMPLETED,
                    'customer_id' => $order->user_id ?: null,
                    'customer_type' => Customer::class,
                    'payment_type' => 'direct',
                    'order_id' => [$order->getKey()],
                ]);
            });
        } elseif (in_array($orderStatus, ['FAILED', 'CANCELLED', 'CANCELED', 'EXPIRED'], true)) {
            Payment::query()
                ->where('order_id', $order->getKey())
                ->where('payment_channel', 'taly')
                ->where('status', '!=', PaymentStatusEnum::COMPLETED)
                ->update(['status' => PaymentStatusEnum::FAILED]);
        }

        return response()->json(['message' => 'Webhook processed']);
    }
}
