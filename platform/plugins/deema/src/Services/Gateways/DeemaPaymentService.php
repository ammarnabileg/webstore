<?php

namespace Botble\Deema\Services\Gateways;

use Botble\Payment\Enums\PaymentStatusEnum;
use Botble\Payment\Services\Traits\PaymentErrorTrait;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Str;

class DeemaPaymentService
{
    use PaymentErrorTrait;

    protected $url;
    protected $apiKey;

    public function __construct()
    {
        $this->url = get_payment_setting('mode', 'deema') == 'live'
            ? 'https://api.deema.me/v1/'
            : 'https://api.sandbox.deema.me/v1/';
        
        $this->apiKey = get_payment_setting('api_key', 'deema');
    }

    public function makePayment(Request $request)
    {
        $amount = $request->input('amount');
        $currency = strtoupper($request->input('currency'));
        
        // Deema requires KWD
        if ($currency != 'KWD' && $currency == 'دينار كويتي') {
            $currency = 'KWD';
        }

        $orderId = $request->input('order_id');
        $callbackUrl = $request->input('callback_url');
        $checkoutData = $request->input('checkout_data', []);

        try {
            $response = Http::withToken($this->apiKey)
                ->withoutVerifying()
                ->post($this->url . 'checkouts', [
                    'amount'      => (float)$amount,
                    'currency'    => 'KWD',
                    'order_id'    => (string)$orderId,
                    'success_url' => $callbackUrl . '?status=success&order_id=' . $orderId,
                    'cancel_url'  => $callbackUrl . '?status=cancel&order_id=' . $orderId,
                    'customer'    => [
                        'first_name' => $checkoutData['name'] ?? 'Guest',
                        'last_name'  => '',
                        'email'      => $checkoutData['email'] ?? '',
                        'phone'      => $checkoutData['phone'] ?? '',
                    ],
                    'items' => [] // Optional in most cases, but can be filled if needed
                ]);

            $result = $response->json();

            if ($response->successful() && isset($result['checkout_url'])) {
                return $result['checkout_url'];
            }

            \Log::error('Deema payment failed: ' . json_encode($result));
            return null;
        } catch (\Exception $e) {
            \Log::error('Deema payment exception: ' . $e->getMessage());
            return null;
        }
    }

    public function afterMakePayment(Request $request)
    {
        $status = $request->input('status');
        $orderId = $request->input('order_id');

        if ($status == 'success') {
            return $this->updatePaymentStatus($orderId, PaymentStatusEnum::COMPLETED);
        }

        return false;
    }

    protected function updatePaymentStatus($orderId, $status)
    {
        $payment = \Botble\Payment\Models\Payment::where('order_id', $orderId)->first();
        if ($payment) {
            $payment->status = $status;
            $payment->save();
            
            do_action(PAYMENT_ACTION_PAYMENT_PROCESSED, [
                'order_id' => $orderId,
                'payment_id' => $payment->id,
                'status' => $status,
            ]);
            
            return true;
        }
        return false;
    }
}
