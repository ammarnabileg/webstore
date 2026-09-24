<?php

use Illuminate\Support\Facades\Route;

Route::group(['namespace' => 'Botble\Klickpay\Http\Controllers', 'middleware' => ['web', 'core']], function () {
    Route::group(['prefix' => 'payments/klickpay'], function () {
        Route::get('status', [
            'as' => 'payments.klickpay.status',
            'uses' => 'KlickpayController@status',
        ]);

        // Server-to-server call authenticated by HMAC; CSRF is excluded in bootstrap/app.php.
        Route::post('webhook', [
            'as' => 'payments.klickpay.webhook',
            'uses' => 'KlickpayController@webhook',
        ])->middleware('throttle:webhooks');
    });
});
