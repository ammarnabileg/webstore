<?php

use Botble\Deema\Http\Controllers\DeemaController;
use Illuminate\Support\Facades\Route;

Route::group(['namespace' => 'Botble\Deema\Http\Controllers', 'middleware' => ['web', 'core']], function () {
    Route::get('payment/deema/callback', [DeemaController::class, 'getCallback'])
        ->name('deema.callback');
});
