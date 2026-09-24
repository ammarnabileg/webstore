<?php

use Botble\Base\Facades\AdminHelper;
use Illuminate\Support\Facades\Route;

AdminHelper::registerRoutes(function (): void {
    Route::group(['namespace' => 'Botble\Ecommerce\Http\Controllers', 'prefix' => 'ecommerce'], function (): void {
        Route::group(['prefix' => 'notifications', 'as' => 'ecommerce.notifications.'], function (): void {
            Route::resource('', 'NotificationController')->parameters(['' => 'notification']);
        });
    });
});
