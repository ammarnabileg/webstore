<?php

use Illuminate\Support\Facades\Route;

Route::group(['namespace' => 'Botble\Klickpay\Http\Controllers', 'middleware' => ['web', 'core']], function () {
    Route::group(['prefix' => 'payments/klickpay'], function () {
        Route::get('status', [
            'as' => 'payments.klickpay.status',
            'uses' => 'KlickpayController@status',
        ]);
        
        // Disable CSRF for webhook since it's an external POST
        Route::post('webhook', [
            'as' => 'payments.klickpay.webhook',
            'uses' => 'KlickpayController@webhook',
            'middleware' => ['api'],
        ]);
    });
});
