<?php

use Botble\Base\Facades\BaseHelper;
use Illuminate\Support\Facades\Route;

Route::group(['namespace' => 'Botble\AIAssistant\Http\Controllers', 'middleware' => ['web', 'core', 'auth']], function () {
    Route::group(['prefix' => BaseHelper::getAdminPrefix() . '/ai-assistant', 'as' => 'ai-assistant.'], function () {
        Route::post('generate', [
            'as' => 'generate',
            'uses' => 'AIAssistantController@generate',
            'permission' => false,
        ]);

        Route::get('settings', [
            'as' => 'settings',
            'uses' => 'AIAssistantController@settings',
        ]);

        Route::post('settings', [
            'as' => 'settings.post',
            'uses' => 'AIAssistantController@updateSettings',
            'permission' => 'ai-assistant.settings',
        ]);
    });
});
