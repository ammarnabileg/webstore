<?php

use App\Http\Controllers\GenerateAiSeoController;
use App\Http\Controllers\GenerateAiSpecsController;
use App\Http\Controllers\WhatsAppAuthController;
use App\Http\Controllers\WhatsAppMarketingController;
use App\Http\Controllers\WhatsAppWebhookController;
use Botble\Base\Facades\AdminHelper;
use Illuminate\Support\Facades\Route;

// Admin-only routes: AdminHelper adds the admin prefix and the ['web', 'core', 'auth'] middleware,
// and the `permission` action is enforced by Botble's ACL Authenticate middleware.
AdminHelper::registerRoutes(function (): void {
    Route::middleware('throttle:admin-tools')->group(function (): void {
        Route::post('ecommerce/products/generate-seo', [GenerateAiSeoController::class, 'generate'])
            ->name('ecommerce.products.generate-seo')
            ->permission('products.edit');

        Route::post('ecommerce/products/generate-specs', [GenerateAiSpecsController::class, 'generate'])
            ->name('ecommerce.products.generate-specs')
            ->permission('products.edit');

        Route::get('whatsapp-marketing', [WhatsAppMarketingController::class, 'getIndex'])
            ->name('whatsapp.marketing.index')
            ->permission('customers.edit');

        Route::post('whatsapp-marketing/send', [WhatsAppMarketingController::class, 'postSend'])
            ->name('whatsapp.marketing.send')
            ->permission('customers.edit');

        Route::post('whatsapp-marketing/test', [WhatsAppMarketingController::class, 'postSendTest'])
            ->name('whatsapp.marketing.test')
            ->permission('customers.edit');
    });
});

Route::post('/api/whatsapp/webhook', [WhatsAppWebhookController::class, 'handle'])
    ->middleware('throttle:webhooks');

Route::middleware('throttle:whatsapp-auth')->group(function (): void {
    Route::post('/api/whatsapp/auth/send-otp', [WhatsAppAuthController::class, 'sendOtp'])->name('whatsapp.auth.send-otp');
    Route::post('/api/whatsapp/auth/verify-otp', [WhatsAppAuthController::class, 'verifyOtp'])->name('whatsapp.auth.verify-otp');
    Route::post('/api/whatsapp/auth/send-magic-link', [WhatsAppAuthController::class, 'sendMagicLink'])->name('whatsapp.auth.send-magic-link');
    Route::post('/api/whatsapp/auth/register-with-otp', [WhatsAppAuthController::class, 'registerWithOtp'])->name('whatsapp.auth.register-with-otp');
    Route::post('/api/whatsapp/auth/complete-profile', [WhatsAppAuthController::class, 'completeProfile'])->name('whatsapp.auth.complete-profile');
    Route::get('/whatsapp/login/{token}', [WhatsAppAuthController::class, 'magicLogin'])->name('whatsapp.magic.login');
});
