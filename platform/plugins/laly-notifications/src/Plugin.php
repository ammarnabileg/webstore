<?php

namespace Botble\LalyNotifications;

use Botble\PluginManagement\Abstracts\PluginOperationAbstract;
use Botble\Setting\Facades\Setting;
use Illuminate\Support\Facades\Schema;

class Plugin extends PluginOperationAbstract
{
    public static function remove(): void
    {
        Schema::dropIfExists('ec_customer_fcm_tokens');
        Schema::dropIfExists('ec_notifications');

        Setting::delete([
            'laly_fcm_api_key',
            'laly_fcm_auth_domain',
            'laly_fcm_project_id',
            'laly_fcm_sender_id',
            'laly_fcm_app_id',
            'laly_fcm_vapid_key',
            'laly_fcm_service_account',
        ]);
    }
}
