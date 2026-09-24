<?php

use Botble\Taly\Http\Controllers\TalyController;
use Illuminate\Support\Facades\Route;

Route::group(['namespace' => 'Botble\Taly\Http\Controllers', 'middleware' => ['web', 'core']], function () {
    Route::get('payments/taly/status', [TalyController::class, 'getPaymentStatus'])
        ->name('payments.taly.status');

    // Server-to-server postBack authenticated by Taly-Signature; CSRF is excluded in bootstrap/app.php.
    // It must not sit behind the 'api' group: Botble's API toggle returns 503 there when the API is off.
    Route::post('payments/taly/webhook', [TalyController::class, 'postWebhook'])
        ->middleware('throttle:webhooks')
        ->name('payments.taly.webhook');
});
