<?php

use Botble\Deema\Http\Controllers\DeemaController;
use Illuminate\Support\Facades\Route;

Route::group(['namespace' => 'Botble\Deema\Http\Controllers', 'prefix' => 'api/v1'], function () {
    Route::post('payment/deema/webhook', [DeemaController::class, 'postWebhook'])
        ->name('deema.webhook');
});
