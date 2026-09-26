<?php

use Botble\PWA\Http\Controllers\PWAController;
use Illuminate\Support\Facades\Route;

Route::group(['namespace' => 'Botble\PWA\Http\Controllers', 'middleware' => ['web', 'core']], function () {
    
    // Admin routes
    Route::group(['prefix' => BaseHelper::getAdminPrefix(), 'middleware' => 'auth'], function () {
        Route::group(['prefix' => 'pwa', 'as' => 'pwa.'], function () {
            // Same permission as Botble's own settings pages; plain 'auth' let any back-office role
            // change the app name/icons shown on customers' home screens.
            Route::get('settings', [PWAController::class, 'getSettings'])->name('settings')->permission('settings.options');
            Route::post('settings', [PWAController::class, 'postSettings'])->name('settings.update')->permission('settings.options');
        });
    });

    // Public PWA routes
    Route::get('manifest.json', [PWAController::class, 'manifest'])->name('pwa.manifest');
    Route::get('service-worker.js', [PWAController::class, 'serviceWorker'])->name('pwa.serviceworker');
    Route::get('offline', [PWAController::class, 'offline'])->name('pwa.offline');
});