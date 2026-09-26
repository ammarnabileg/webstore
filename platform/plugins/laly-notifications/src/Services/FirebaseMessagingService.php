<?php

namespace Botble\LalyNotifications\Services;

use Botble\LalyNotifications\Models\CustomerFcmToken;
use Botble\LalyNotifications\Models\Notification;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;

class FirebaseMessagingService
{
    protected function getServiceAccount(): ?array
    {
        // Admin setting first (stored encrypted), then FCM_SERVICE_ACCOUNT_BASE64 from .env.
        $json = laly_notifications_service_account_json();

        if (! $json && ($base64 = config('plugins.laly-notifications.general.service_account_base64'))) {
            $json = base64_decode($base64, true) ?: null;
        }

        $data = $json ? json_decode($json, true) : null;

        return is_array($data) ? $data : null;
    }

    public function getProjectId(): ?string
    {
        $serviceAccount = $this->getServiceAccount();
        return $serviceAccount['project_id'] ?? null;
    }

    public function getAccessToken(): ?string
    {
        $serviceAccount = $this->getServiceAccount();
        if (! $serviceAccount || ! isset($serviceAccount['client_email']) || ! isset($serviceAccount['private_key'])) {
            Log::error('FCM service account is not configured (admin push settings or FCM_SERVICE_ACCOUNT_BASE64).');
            return null;
        }

        return Cache::remember('fcm_oauth_access_token_' . md5($serviceAccount['client_email']), 3500, function () use ($serviceAccount) {
            $header = json_encode(['alg' => 'RS256', 'typ' => 'JWT']);
            $now = time();
            $claim = json_encode([
                'iss' => $serviceAccount['client_email'],
                'scope' => 'https://www.googleapis.com/auth/firebase.messaging',
                'aud' => 'https://oauth2.googleapis.com/token',
                'exp' => $now + 3600,
                'iat' => $now,
            ]);

            $base64UrlHeader = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($header));
            $base64UrlClaim = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($claim));
            $signature = '';

            $privateKey = openssl_pkey_get_private($serviceAccount['private_key']);

            if (! $privateKey || ! openssl_sign($base64UrlHeader . '.' . $base64UrlClaim, $signature, $privateKey, 'SHA256')) {
                Log::error('FCM OpenSSL Sign failed: ' . openssl_error_string());
                return null;
            }

            $base64UrlSignature = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($signature));
            $jwt = $base64UrlHeader . '.' . $base64UrlClaim . '.' . $base64UrlSignature;

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, 'https://oauth2.googleapis.com/token');
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query([
                'grant_type' => 'urn:ietf:params:oauth:grant-type:jwt-bearer',
                'assertion' => $jwt,
            ]));
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_TIMEOUT, 15);
            $response = curl_exec($ch);
            curl_close($ch);

            $data = is_string($response) ? json_decode($response, true) : null;

            if (! is_array($data)) {
                Log::error('FCM OAuth token request failed (no response).');

                return null;
            }

            if (isset($data['error'])) {
                Log::error('FCM OAuth Token Exchange Failed: ' . json_encode($data));
                return null;
            }

            return $data['access_token'] ?? null;
        });
    }

    public function sendMulticast(array $tokens, Notification $notification): array
    {
        if (empty($tokens)) {
            return ['success' => 0, 'failure' => 0, 'invalid_tokens' => []];
        }

        $accessToken = $this->getAccessToken();
        $projectId = $this->getProjectId();

        if (! $accessToken || ! $projectId) {
            Log::error('Cannot send FCM Notification: Access token or Project ID missing.');
            return ['success' => 0, 'failure' => count($tokens), 'invalid_tokens' => []];
        }

        $url = "https://fcm.googleapis.com/v1/projects/{$projectId}/messages:send";
        $headers = [
            'Authorization: Bearer ' . $accessToken,
            'Content-Type: application/json',
        ];

        $multiCurl = curl_multi_init();
        $curlHandles = [];
        $tokenMap = [];

        foreach ($tokens as $index => $token) {
            $payload = [
                'message' => [
                    'token' => $token,
                    'notification' => [
                        'title' => $notification->title,
                        'body' => $notification->description ?? '',
                    ],
                    'webpush' => [
                        'fcm_options' => [
                            'link' => $notification->target_url,
                        ],
                    ],
                    'data' => [
                        'url' => $notification->target_url,
                    ],
                ],
            ];

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_TIMEOUT, 15);

            curl_multi_add_handle($multiCurl, $ch);
            $curlHandles[$index] = $ch;
            $tokenMap[$index] = $token;
        }

        $active = null;
        do {
            $status = curl_multi_exec($multiCurl, $active);
            if ($active) {
                curl_multi_select($multiCurl);
            }
        } while ($active && $status == CURLM_OK);

        $successCount = 0;
        $failureCount = 0;
        $invalidTokens = [];

        foreach ($curlHandles as $index => $ch) {
            $response = curl_multi_getcontent($ch);
            $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
            curl_multi_remove_handle($multiCurl, $ch);
            curl_close($ch);

            $responseData = json_decode($response, true);

            if ($httpCode == 200) {
                $successCount++;
            } else {
                $failureCount++;
                $errorCode = $responseData['error']['details'][0]['errorCode'] ?? ($responseData['error']['status'] ?? 'UNKNOWN');
                
                if (in_array($errorCode, ['UNREGISTERED', 'INVALID_ARGUMENT', 'SENDER_ID_MISMATCH', 'NOT_FOUND', 404])) {
                    $invalidTokens[] = $tokenMap[$index];
                } else {
                    Log::warning('FCM send error: ' . $errorCode);
                }
            }
        }

        curl_multi_close($multiCurl);

        if (! empty($invalidTokens)) {
            CustomerFcmToken::whereIn('token', $invalidTokens)->delete();
            Log::info('FCM Cleaned up invalid tokens: ' . count($invalidTokens));
        }

        return [
            'success' => $successCount,
            'failure' => $failureCount,
            'invalid_tokens' => $invalidTokens,
        ];
    }
}
