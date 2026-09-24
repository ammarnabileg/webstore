<?php

namespace Botble\Klickpay\Services\Gateways;

use Botble\Payment\Services\Traits\PaymentErrorTrait;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class KlickpayPaymentService
{
    use PaymentErrorTrait;

    protected string $baseUrl;
    protected ?string $clientId;
    protected ?string $clientSecret;
    protected ?string $staticToken;

    public function __construct()
    {
        $environment = get_payment_setting('environment', 'klickpay', 'staging');
        $this->baseUrl = $environment === 'production' 
            ? 'https://api.klick-pay.com/v3' 
            : 'https://api.staging.klick-pay.com/v3';
            
        $this->clientId = get_payment_setting('client_id', 'klickpay');
        $this->clientSecret = get_payment_setting('client_secret', 'klickpay');
        $this->staticToken = get_payment_setting('static_token', 'klickpay');
    }

    public function getToken(): ?string
    {
        if ($this->staticToken) {
            return trim($this->staticToken);
        }
        try {
            $response = Http::timeout(20)->withHeaders([
                'client-id' => $this->clientId,
                'client-secret' => $this->clientSecret,
                'Accept' => 'application/json',
            ])->post($this->baseUrl . '/auth/token');

            if ($response->successful()) {
                $data = $response->json();
                $d = $data['data'] ?? [];
                return $d['access_token'] ?? $d['bearer_token'] ?? $d['token'] 
                    ?? $data['access_token'] ?? $data['bearer_token'] ?? $data['token'] ?? null;
            }
            
            Log::error('klickpay Get Token Failed', ['status' => $response->status()]);
        } catch (\Exception $e) {
            Log::error('klickpay Get Token Exception: ' . $e->getMessage());
        }

        return null;
    }

    public function execute(array $data): ?string
    {
        $token = $this->getToken();

        if (! $token) {
            $this->setErrorMessage(__('Failed to authenticate with klickpay gateway.'));
            return null;
        }

        try {
            $clientName = Arr::get($data, 'address.name');
            $clientName = !empty($clientName) ? (string)$clientName : 'Customer';

            $clientEmail = Arr::get($data, 'address.email');
            // Must be valid email format
            if (!filter_var($clientEmail, FILTER_VALIDATE_EMAIL)) {
                $clientEmail = 'sales@brilliant-kw.com';
            }

            $clientPhone = Arr::get($data, 'address.phone');
            $clientPhone = !empty($clientPhone) ? (string)$clientPhone : '50000000';
            
            // KlickPay requires numeric string for phone in some cases, ensure it's clean
            $clientPhone = preg_replace('/[^0-9+]/', '', $clientPhone);
            if (empty($clientPhone)) {
                $clientPhone = '50000000';
            }
            
            $orderIdStr = (string)$data['order_id'];
            $orderToken = \Botble\Ecommerce\Models\Order::query()->whereKey($data['order_id'])->value('token');
            $amount = (float)str_replace(',', '', (string)$data['amount']);
            
            $payload = [
                'client_name' => $clientName,
                'client_email' => $clientEmail,
                'client_phone' => $clientPhone,
                'transction_reference' => 'ORD-' . $orderIdStr,
                'transction_amount' => $amount,
                // The return URL carries the order's secret checkout token, never the sequential id.
                'success_page' => $data['callback_url'] . '?status=success&t=' . urlencode((string) $orderToken),
                'error_page' => $data['callback_url'] . '?status=error&t=' . urlencode((string) $orderToken),
                'source' => 'web_app',
                'transaction_details' => [
                    'total_items' => 1,
                    'sub_total' => $amount,
                    'discount' => 0,
                    'tax' => 0,
                    'total' => $amount,
                    'items' => [
                        [
                            'item_code' => 'SKU-' . $orderIdStr,
                            'item_name' => 'Order #' . $orderIdStr,
                            'item_quantity' => 1,
                            'item_unit_price' => $amount,
                            'item_total_price' => $amount,
                            'item_currency' => strtoupper($data['currency']),
                        ]
                    ],
                ]
            ];

            $response = Http::timeout(20)->withHeaders([
                'Authorization' => 'Bearer ' . $token,
                'Content-Type' => 'application/json',
                'Accept' => 'application/json',
            ])->post($this->baseUrl . '/payments/general-link', $payload);

            if ($response->successful()) {
                $result = $response->json();
                $paymentUrl = Arr::get($result, 'data.payment_url');
                $paymentId = Arr::get($result, 'data.payment_id');
                
                if ($paymentId) {
                    // Kept server-side so the return page can verify this payment with KlickPay
                    // instead of trusting ids from the URL.
                    session(['klickpay_payment_id_' . $orderIdStr => $paymentId]);
                    Cache::put('klickpay_payment_id_' . $orderIdStr, $paymentId, now()->addDays(2));
                }
                
                return $paymentUrl;
            }

            Log::error('klickpay Create Payment Link Failed: ' . $response->body());
            $this->setErrorMessage(__('Failed to create payment link: ') . Arr::get($response->json(), 'message', 'Unknown error'));
            
        } catch (\Exception $e) {
            Log::error('klickpay Create Payment Exception: ' . $e->getMessage());
            $this->setErrorMessage($e->getMessage());
        }

        return null;
    }

    public function getPaymentStatus(string $paymentId): ?array
    {
        $token = $this->getToken();
        if (! $token) return null;

        try {
            $response = Http::timeout(20)->withHeaders([
                'Authorization' => 'Bearer ' . $token,
                'Content-Type' => 'application/json',
                'Accept' => 'application/json',
            ])->post($this->baseUrl . '/payments/status', [
                'payment_id' => $paymentId
            ]);

            if ($response->successful()) {
                return $response->json();
            }
            
            Log::error('klickpay Status Failed: ' . $response->body());
        } catch (\Exception $e) {
            Log::error('klickpay Status Exception: ' . $e->getMessage());
        }

        return null;
    }
}
