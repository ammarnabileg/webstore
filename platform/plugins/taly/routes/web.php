<?php

use Botble\Taly\Http\Controllers\TalyController;
use Illuminate\Support\Facades\Route;

Route::group(['namespace' => 'Botble\Taly\Http\Controllers', 'middleware' => ['web', 'core']], function () {
    Route::get('payments/taly/status', [TalyController::class, 'getPaymentStatus'])
        ->name('payments.taly.status');
});

Route::group(['namespace' => 'Botble\Taly\Http\Controllers', 'middleware' => ['api']], function () {
    Route::post('payments/taly/webhook', [TalyController::class, 'postWebhook'])
        ->name('payments.taly.webhook');
});
