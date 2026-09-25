<?php

namespace Botble\LalyNotifications\Http\Controllers;

use Botble\Base\Facades\PageTitle;
use Botble\Base\Http\Controllers\BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;

class SettingController extends BaseController
{
    protected const WEB_KEYS = [
        'laly_fcm_api_key' => 'apiKey',
        'laly_fcm_auth_domain' => 'authDomain',
        'laly_fcm_project_id' => 'projectId',
        'laly_fcm_sender_id' => 'messagingSenderId',
        'laly_fcm_app_id' => 'appId',
        'laly_fcm_vapid_key' => 'vapidKey',
    ];

    public function edit()
    {
        PageTitle::setTitle(trans('plugins/laly-notifications::notifications.settings'));

        $values = [];
        foreach (array_keys(self::WEB_KEYS) as $key) {
            $values[$key] = setting($key);
        }

        $serviceAccount = laly_notifications_service_account_json();
        $serviceAccountEmail = $serviceAccount ? (json_decode($serviceAccount, true)['client_email'] ?? null) : null;

        return view('plugins/laly-notifications::settings', [
            'values' => $values,
            'serviceAccountEmail' => $serviceAccountEmail,
            'envFallback' => (bool) config('plugins.laly-notifications.general.service_account_base64'),
            'webConfigured' => laly_notifications_web_config() !== null,
        ]);
    }

    public function update(Request $request)
    {
        $rules = ['service_account' => ['nullable', 'string', 'max:10000']];
        foreach (array_keys(self::WEB_KEYS) as $key) {
            $rules[$key] = ['nullable', 'string', 'max:255', 'regex:/^[A-Za-z0-9_.:\-]*$/'];
        }

        $data = $request->validate($rules);

        $settings = setting();
        foreach (array_keys(self::WEB_KEYS) as $key) {
            $settings->set($key, trim((string) ($data[$key] ?? '')));
        }

        // The private key is only replaced when a new JSON is pasted; the form never echoes it back.
        if ($json = trim((string) ($data['service_account'] ?? ''))) {
            $decoded = json_decode($json, true);

            if (! is_array($decoded) || empty($decoded['client_email']) || empty($decoded['private_key']) || empty($decoded['project_id'])) {
                return back()->withInput($request->except('service_account'))
                    ->withErrors(['service_account' => trans('plugins/laly-notifications::notifications.invalid_service_account')]);
            }

            $settings->set('laly_fcm_service_account', Crypt::encryptString($json));
        } elseif ($request->boolean('remove_service_account')) {
            $settings->set('laly_fcm_service_account', '');
        }

        $settings->save();

        return redirect()->route('laly-notifications.settings')
            ->with('success_msg', trans('core/base::notices.update_success_message'));
    }
}
