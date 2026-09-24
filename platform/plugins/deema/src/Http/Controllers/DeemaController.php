<?php

namespace Botble\Deema\Http\Controllers;

use Botble\Base\Http\Controllers\BaseController;
use Botble\Deema\Services\Gateways\DeemaPaymentService;
use Botble\Payment\Enums\PaymentStatusEnum;
use Botble\Payment\Models\Payment;
use Botble\Payment\Supports\PaymentHelper;
use Illuminate\Http\Request;

class DeemaController extends BaseController
{
    public function getCallback(Request $request, DeemaPaymentService $deemaPaymentService)
    {
        $status = $request->input('status');
        $orderId = $request->input('order_id');

        if ($status == 'success') {
            $deemaPaymentService->afterMakePayment($request);

            return PaymentHelper::redirectAfterPayment($orderId);
        }

        return PaymentHelper::redirectAfterPayment($orderId, PaymentStatusEnum::FAILED);
    }

    public function postWebhook(Request $request)
    {
        // Simple webhook handling - real usage should verify signatures
        $payload = $request->all();
        \Log::info('Deema Webhook received: ' . json_encode($payload));

        $orderId = $payload['order_id'] ?? null;
        $status = $payload['status'] ?? null;

        if ($orderId && $status == 'captured') {
            $payment = Payment::where('order_id', $orderId)->first();
            if ($payment && $payment->status != PaymentStatusEnum::COMPLETED) {
                $payment->status = PaymentStatusEnum::COMPLETED;
                $payment->save();
                
                do_action(PAYMENT_ACTION_PAYMENT_PROCESSED, [
                    'order_id' => $orderId,
                    'payment_id' => $payment->id,
                    'status' => PaymentStatusEnum::COMPLETED,
                ]);
            }
        }

        return response()->json(['status' => 'success']);
    }
}
