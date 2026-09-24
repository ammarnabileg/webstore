<?php

namespace Botble\Klickpay\Http\Controllers;

use Botble\Base\Http\Controllers\BaseController;
use Botble\Base\Http\Responses\BaseHttpResponse;
use Botble\Payment\Enums\PaymentStatusEnum;
use Botble\Payment\Models\Payment;
use Botble\Klickpay\Services\Gateways\KlickpayPaymentService;
use Illuminate\Support\Arr;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use OrderHelper;

class KlickpayController extends BaseController
{
    public function status(Request $request, BaseHttpResponse $response, klickpayPaymentService $klickpayService)
    {
        $status = $request->input('status');
        $orderId = $request->input('order_id');
        $paymentId = $request->input('payment_id'); // If returned by klickpay in redirect URL

        if (! $orderId) {
            return $response
                ->setError()
                ->setNextUrl(route('public.checkout.information', $request->input('order_id', '')))
                ->setMessage(__('Payment failed or invalid order.'));
        }

        if ($status === 'success') {
            $paymentId = session('klickpay_payment_id_' . $orderId) ?: $paymentId;
            
            if ($paymentId) {
                // Verify status with API
                $statusData = $klickpayService->getPaymentStatus($paymentId);
                $apiStatus = Arr::get($statusData, 'data.status');
                
                // If API says it's not paid, we reject it locally even if they forged the URL!
                if ($apiStatus !== 'paid' && $apiStatus !== 'success' && $apiStatus !== 'COMPLETED') {
                    $status = 'failed';
                }
            } else {
                // If we don't have a payment ID to verify, it's highly suspicious.
                // We'll trust the webhook for DB update, but we shouldn't show a false success page.
                // However, some gateways don't return payment ID immediately, so we allow it 
                // but emphasize that only the webhook actually marks it paid.
            }
        }

        if ($status !== 'success') {
            return $response
                ->setError()
                ->setNextUrl(route('public.checkout.information', $orderId))
                ->setMessage(__('Payment was cancelled or failed.'));
        }

        // We assume success if we reach here (final confirmation by webhook)
        return $response
            ->setNextUrl(route('public.checkout.success', $orderId))
            ->setMessage(__('Payment processed successfully.'));
    }

    public function webhook(Request $request)
    {
        $rawBody = $request->getContent();
        $signature = (string) $request->header('X-KlickPay-Signature');
        $eventHeader = $request->header('X-KlickPay-Event');
        
        $secret = get_payment_setting('webhook_secret', 'klickpay');
        
        if (empty($secret)) {
            Log::error('klickpay Webhook: Secret not configured.');
            return response()->json(['error' => 'Webhook not configured'], 500);
        }

        $expected = hash_hmac('sha256', $rawBody, $secret);

        if (! hash_equals($expected, $signature)) {
            Log::warning('klickpay Webhook: Signature mismatch.', ['received' => $signature, 'expected' => $expected]);
            return response()->json(['error' => 'Signature mismatch'], 401);
        }

        $payload = json_decode($rawBody, true);
        $eventType = $payload['event_type'] ?? $eventHeader;

        Log::info('klickpay Webhook Received', ['event' => $eventType, 'payload' => $payload]);

        if ($eventType === 'payment.success') {
            $orderId = $payload['transction_reference'] ?? null;
            $paymentId = $payload['payment_id'] ?? null;
            $amount = $payload['transction_amount'] ?? 0;

            if ($orderId) {
                // Update payment status in Botble
                $payment = Payment::where('order_id', $orderId)
                                  ->where('payment_channel', 'klickpay')
                                  ->first();
                                  
                if ($payment) {
                    $payment->status = PaymentStatusEnum::COMPLETED;
                    $payment->charge_id = $paymentId;
                    $payment->save();
                } else {
                    // Create payment if not exists
                    Payment::create([
                        'amount' => $amount,
                        'currency' => 'KWD',
                        'payment_channel' => 'klickpay',
                        'status' => PaymentStatusEnum::COMPLETED,
                        'payment_type' => 'confirm',
                        'order_id' => $orderId,
                        'charge_id' => $paymentId,
                        'customer_id' => 0,
                    ]);
                }
                
                // Confirm order
                OrderHelper::confirmPayment($orderId);
            }
        }

        return response('OK', 200);
    }
}
