<?php

use Illuminate\Support\Facades\Route;

Route::group(['namespace' => 'Botble\SystemWizard\Http\Controllers', 'middleware' => ['web', 'core']], function () {

    Route::group(['prefix' => BaseHelper::getAdminPrefix(), 'middleware' => 'auth'], function () {
        Route::group(['prefix' => 'system-wizard', 'as' => 'system-wizard.'], function () {
            Route::match(['GET', 'POST'], '/', [
                'as'   => 'index',
                'uses' => 'SystemWizardController@index',
                'permission' => 'system-wizard.index',
            ]);
            
            Route::get('settings', [
                'as'   => 'settings',
                'uses' => 'SystemWizardController@settings',
                'permission' => 'system-wizard.settings',
            ]);
            
            Route::post('settings', [
                'as'   => 'settings.post',
                'uses' => 'SystemWizardController@saveSettings',
                'permission' => 'system-wizard.settings',
            ]);

            Route::post('leads/{id}/status', [
                'as'   => 'leads.status',
                'uses' => 'SystemWizardController@updateStatus',
                'permission' => 'system-wizard.edit',
            ])->whereNumber('id');
        });
    });

    // Frontend API endpoints
    Route::group(['prefix' => 'ajax/vue', 'as' => 'public.system-wizard.'], function () {
        Route::get('wizard-catalog', [
            'as'   => 'catalog',
            'uses' => 'PublicSystemWizardController@catalog',
        ]);
        
        Route::post('project-leads', [
            'as'   => 'store-lead',
            'uses' => 'PublicSystemWizardController@storeLead',
        ])->middleware('throttle:wizard-leads');

        Route::post('wizard-events', [
            'as'   => 'events',
            'uses' => 'SystemWizardEventController@store',
        ])->middleware('throttle:wizard-events');
    });
});
