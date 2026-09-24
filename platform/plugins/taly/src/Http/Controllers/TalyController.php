<?php

namespace Botble\Taly\Http\Controllers;

use Botble\Base\Http\Controllers\BaseController;
use Botble\Base\Http\Responses\BaseHttpResponse;
use Botble\Payment\Enums\PaymentStatusEnum;
use Botble\Payment\Models\Payment;
use Botble\Payment\Supports\PaymentHelper;
use Botble\Taly\Services\Gateways\TalyPaymentService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class TalyController extends BaseController
{
    public function getPaymentStatus(Request $request, TalyPaymentService $talyService, BaseHttpResponse $response)
    {
        $orderToken = $request->input('orderToken');
        
        if (!$orderToken) {
            return $response
                ->setError()
                ->setNextUrl(PaymentHelper::getCancelURL())
                ->setMessage('Payment failed or cancelled.');
        }

        // Taly typically updates status via Webhook, but we can do a quick check here if Taly provides a status API.
        // For now, we assume success if we got back and redirected to the success page.
        // The Webhook will handle the official confirmation.

        return $response
            ->setNextUrl(PaymentHelper::getRedirectURL())
            ->setMessage(trans('plugins/payment::payment.checkout_success'));
    }

    public function postWebhook(Request $request, TalyPaymentService $talyService)
    {
        $payload = $request->input();
        $signature = $request->header('Taly-Signature');

        if (!$signature || !$talyService->verifySignature($payload, $signature)) {
            Log::error('Taly Webhook: Invalid Signature', ['payload' => $payload, 'signature' => $signature]);
            return response()->json(['message' => 'Invalid signature'], 403);
        }

        $orderStatus = $payload['orderStatus'] ?? '';
        $merchantOrderId = $payload['merchantOrderId'] ?? '';
        $amount = $payload['amount'] ?? 0;

        $payment = Payment::where('order_id', $merchantOrderId)->first();

        if (!$payment) {
            Log::error('Taly Webhook: Payment not found', ['merchantOrderId' => $merchantOrderId]);
            return response()->json(['message' => 'Payment not found'], 404);
        }

        switch (strtoupper($orderStatus)) {
            case 'CONFIRMED':
            case 'PAID':
                PaymentHelper::storeCheckoutPayment([
                    'amount' => $amount,
                    'currency' => $payload['currency'] ?? 'KWD',
                    'charge_id' => $payload['orderToken'],
                    'payment_channel' => 'taly',
                    'status' => PaymentStatusEnum::COMPLETED,
                    'customer_id' => $payment->customer_id,
                    'payment_type' => 'direct',
                    'order_id' => $merchantOrderId,
                ]);
                break;
            case 'FAILED':
            case 'CANCELLED':
                $payment->status = PaymentStatusEnum::FAILED;
                $payment->save();
                break;
        }

        return response()->json(['message' => 'Webhook processed']);
    }
}
