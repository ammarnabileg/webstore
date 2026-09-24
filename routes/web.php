<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\GenerateAiSeoController;

use App\Http\Controllers\GenerateAiSpecsController;

Route::group(['middleware' => ['core', 'throttle:10,1']], function () {
    Route::post(
        config('core.base.general.admin_dir') . '/ecommerce/products/generate-seo',
        [GenerateAiSeoController::class, 'generate']
    )->name('ecommerce.products.generate-seo');

    Route::post(
        config('core.base.general.admin_dir') . '/ecommerce/products/generate-specs',
        [GenerateAiSpecsController::class, 'generate']
    )->name('ecommerce.products.generate-specs');

    Route::get(config('core.base.general.admin_dir') . '/whatsapp-marketing', [\App\Http\Controllers\WhatsAppMarketingController::class, 'getIndex'])->name('whatsapp.marketing.index');
    Route::post(config('core.base.general.admin_dir') . '/whatsapp-marketing/send', [\App\Http\Controllers\WhatsAppMarketingController::class, 'postSend'])->name('whatsapp.marketing.send');
    Route::post(config('core.base.general.admin_dir') . '/whatsapp-marketing/test', [\App\Http\Controllers\WhatsAppMarketingController::class, 'postSendTest'])->name('whatsapp.marketing.test');
});

Route::post('/api/whatsapp/webhook', [\App\Http\Controllers\WhatsAppWebhookController::class, 'handle']);

Route::post('/api/whatsapp/auth/send-otp', [\App\Http\Controllers\WhatsAppAuthController::class, 'sendOtp'])->name('whatsapp.auth.send-otp');
Route::post('/api/whatsapp/auth/verify-otp', [\App\Http\Controllers\WhatsAppAuthController::class, 'verifyOtp'])->name('whatsapp.auth.verify-otp');
Route::post('/api/whatsapp/auth/send-magic-link', [\App\Http\Controllers\WhatsAppAuthController::class, 'sendMagicLink'])->name('whatsapp.auth.send-magic-link');
Route::post('/api/whatsapp/auth/register-with-otp', [\App\Http\Controllers\WhatsAppAuthController::class, 'registerWithOtp'])->name('whatsapp.auth.register-with-otp');
Route::post('/api/whatsapp/auth/complete-profile', [\App\Http\Controllers\WhatsAppAuthController::class, 'completeProfile'])->name('whatsapp.auth.complete-profile');
Route::get('/whatsapp/login/{token}', [\App\Http\Controllers\WhatsAppAuthController::class, 'magicLogin'])->name('whatsapp.magic.login');
