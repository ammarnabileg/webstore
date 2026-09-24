<?php

namespace Botble\Taly\Services\Gateways;

use Botble\Payment\Services\Traits\PaymentErrorTrait;
use Exception;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class TalyPaymentService
{
    use PaymentErrorTrait;

    protected ?string $merchantId;
    protected ?string $secretKey;
    protected string $url;
    protected bool $isTestMode;

    public function __construct()
    {
        $this->isTestMode = (bool) get_payment_setting('mode', 'taly', true);
        $this->merchantId = get_payment_setting('merchant_id', 'taly');
        $this->secretKey = get_payment_setting('secret_key', 'taly');
        $this->url = !$this->isTestMode
            ? 'https://api.taly.io/api'
            : 'https://dev-api.taly.io/api';
    }

    public function execute(array $data): ?string
    {
        try {
            $response = Http::withHeaders([
                'X-Merchant-Id' => $this->merchantId,
                'Content-Type' => 'application/json',
            ])->timeout(20)->post($this->url . '/order/initiate', [
                'amount' => $data['amount'],
                'currency' => strtoupper($data['currency']) == 'KWD' || $data['currency'] == 'دينار كويتي' ? 'KWD' : $data['currency'],
                'merchantOrderId' => $data['order_id'],
                'successUrl' => $data['callback_url'] . '?result=success&order_id=' . $data['order_id'],
                'failUrl' => $data['callback_url'] . '?result=failed&order_id=' . $data['order_id'],
                'postBackUrl' => route('payments.taly.webhook'),
                'customer' => [
                    'firstName' => $data['address']['first_name'] ?? 'Customer',
                    'lastName' => $data['address']['last_name'] ?? 'Taly',
                    'email' => $data['address']['email'] ?? 'customer@example.com',
                    'mobile' => $data['address']['phone'] ?? '0000000000',
                ],
            ]);

            if ($response->failed()) {
                $this->setErrorMessage($response->json('message') ?? 'Unable to initiate payment with Taly.');
                return null;
            }

            $result = $response->json();

            if (isset($result['checkout_url'])) {
                return $result['checkout_url'];
            }

            $this->setErrorMessage('Invalid response from Taly API.');
            return null;

        } catch (Exception $exception) {
            $this->setErrorMessage($exception->getMessage());
            return null;
        }
    }

    public function verifySignature(array $payload, string $signature): bool
    {
        if (empty($this->secretKey)) {
            return false;
        }

        // Taly: sort keys ascending, join the values with '&', HMAC-SHA256 with the secret key.
        ksort($payload);

        $values = [];
        foreach ($payload as $value) {
            if (is_array($value)) {
                // Nested values are not part of Taly's flat signature format; refuse rather than guess.
                return false;
            }

            $values[] = is_bool($value) ? ($value ? 'true' : 'false') : (string) $value;
        }

        $computedSignature = hash_hmac('sha256', implode('&', $values), $this->secretKey);

        $signature = trim($signature);

        return hash_equals($computedSignature, ctype_xdigit($signature) ? strtolower($signature) : $signature);
    }
}
