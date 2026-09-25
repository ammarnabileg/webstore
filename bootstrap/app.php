<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

// Order listeners in app/Listeners are picked up by Laravel's event discovery; do not also
// register them in a provider or they will run twice.
return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->append(\App\Http\Middleware\SecurityHeaders::class);

        // Reject path traversal in a client-supplied `file_name` (data-synchronize importer
        // move/delete under storage/app). Guards a vendored package we do not patch directly.
        $middleware->append(\App\Http\Middleware\BlockFileNameTraversal::class);

        // Trusted proxies are applied in AppServiceProvider::boot(): .env is not loaded yet when
        // this callback runs, so reading TRUSTED_PROXIES here would silently see nothing.

        // Server-to-server callbacks authenticate with their own token/signature, not a CSRF token.
        $middleware->validateCsrfTokens(except: [
            'api/whatsapp/webhook',
            'payments/klickpay/webhook',
            'payments/taly/webhook',
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        //
    })->create();
