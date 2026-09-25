<?php

use Illuminate\Support\Facades\Crypt;

if (! function_exists('laly_notifications_web_config')) {
    /**
     * Public Firebase web-app config for the storefront (these values are public by design).
     * Null when push is not configured, so the storefront skips Firebase entirely.
     */
    function laly_notifications_web_config(): ?array
    {
        $config = [
            'apiKey' => (string) setting('laly_fcm_api_key'),
            'authDomain' => (string) setting('laly_fcm_auth_domain'),
            'projectId' => (string) setting('laly_fcm_project_id'),
            'messagingSenderId' => (string) setting('laly_fcm_sender_id'),
            'appId' => (string) setting('laly_fcm_app_id'),
            'vapidKey' => (string) setting('laly_fcm_vapid_key'),
        ];

        return $config['apiKey'] && $config['projectId'] && $config['messagingSenderId'] && $config['appId'] && $config['vapidKey']
            ? $config
            : null;
    }
}

if (! function_exists('laly_notifications_service_account_json')) {
    /**
     * Server-side service account JSON (private key), stored encrypted in settings.
     */
    function laly_notifications_service_account_json(): ?string
    {
        $encrypted = setting('laly_fcm_service_account');

        if (! $encrypted) {
            return null;
        }

        try {
            return Crypt::decryptString($encrypted);
        } catch (Throwable) {
            return null;
        }
    }
}
