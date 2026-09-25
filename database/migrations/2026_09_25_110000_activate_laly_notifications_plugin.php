<?php

use Botble\PluginManagement\Services\PluginService;
use Illuminate\Database\Migrations\Migration;

/**
 * Push notifications moved out of the stock ecommerce plugin into platform/plugins/laly-notifications.
 * Activate it on deploy so the storefront list, the FCM token endpoint and the admin pages keep
 * working without a manual step. Its tables already exist (same migration names), so nothing is
 * recreated.
 */
return new class () extends Migration {
    public function up(): void
    {
        if (! function_exists('is_plugin_active') || ! is_plugin_active('ecommerce') || is_plugin_active('laly-notifications')) {
            return;
        }

        $result = app(PluginService::class)->activate('laly-notifications');

        if (! empty($result['error'])) {
            throw new RuntimeException('Could not activate laly-notifications: ' . ($result['message'] ?? 'unknown error'));
        }
    }

    public function down(): void
    {
        // Deactivating would silently drop push notifications; do it from the admin if intended.
    }
};
