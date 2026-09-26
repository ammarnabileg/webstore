<?php

use Botble\Base\Facades\AdminHelper;
use Botble\LalyNotifications\Http\Controllers\NotificationController;
use Botble\LalyNotifications\Http\Controllers\PublicNotificationController;
use Botble\LalyNotifications\Http\Controllers\SettingController;
use Botble\Theme\Facades\Theme;
use Illuminate\Support\Facades\Route;

AdminHelper::registerRoutes(function (): void {
    Route::group(['prefix' => 'push-notifications', 'as' => 'laly-notifications.'], function (): void {
        Route::get('settings', [SettingController::class, 'edit'])->name('settings')->permission('laly-notifications.settings');
        Route::post('settings', [SettingController::class, 'update'])->name('settings.update')->permission('laly-notifications.settings');

        Route::resource('', NotificationController::class)->parameters(['' => 'notification']);
    });
});

// Storefront endpoints used by the laly-vue theme (same URLs and names it always called).
Theme::registerRoutes(function (): void {
    Route::group(['prefix' => 'ajax/vue', 'as' => 'public.ajax.vue.'], function (): void {
        Route::get('notifications', [PublicNotificationController::class, 'index'])->name('notifications');
        Route::post('fcm-token', [PublicNotificationController::class, 'storeToken'])
            ->middleware('throttle:fcm-token')
            ->name('fcm-token');
    });
});
