<?php

namespace Botble\Deema\Services\Gateways;

use Botble\Payment\Services\Traits\PaymentErrorTrait;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

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
        // Amount, order and customer come from the server-side order, never from the checkout form.
        $paymentData = apply_filters(PAYMENT_FILTER_PAYMENT_DATA, [], $request);
        $orderIds = (array) ($paymentData['order_id'] ?? []);
        $orderId = reset($orderIds);

        if (! $orderId || ! isset($paymentData['amount'])) {
            $this->setErrorMessage(__('Invalid order.'));

            return null;
        }

        $callbackUrl = route('deema.callback');
        $orderToken = \Botble\Ecommerce\Models\Order::query()->whereKey($orderId)->value('token');
        $address = $paymentData['address'] ?? [];

        try {
            $response = Http::withToken($this->apiKey)
                ->timeout(20)
                ->post($this->url . 'checkouts', [
                    'amount'      => (float) $paymentData['amount'],
                    'currency'    => 'KWD',
                    'order_id'    => (string) $orderId,
                    // The return URL carries the order's secret checkout token, never the sequential id.
                    'success_url' => $callbackUrl . '?status=success&t=' . urlencode((string) $orderToken),
                    'cancel_url'  => $callbackUrl . '?status=cancel&t=' . urlencode((string) $orderToken),
                    'customer'    => [
                        'first_name' => $address['name'] ?? 'Guest',
                        'last_name'  => '',
                        'email'      => $address['email'] ?? '',
                        'phone'      => $address['phone'] ?? '',
                    ],
                    'items' => [],
                ]);

            $result = $response->json();

            if ($response->successful() && isset($result['checkout_url'])) {
                return $result['checkout_url'];
            }

            Log::error('Deema payment failed', ['status' => $response->status(), 'order_id' => $orderId]);

            return null;
        } catch (\Exception $e) {
            Log::error('Deema payment exception: ' . $e->getMessage());

            return null;
        }
    }
}
