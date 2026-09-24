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

        // Behind a CDN/load balancer, set TRUSTED_PROXIES to its IP ranges (comma separated) so
        // rate limits see the real client IP. Empty = trust nobody (X-Forwarded-For ignored).
        $trusted = array_filter(array_map('trim', explode(',', (string) env('TRUSTED_PROXIES', ''))));
        if ($trusted) {
            $middleware->trustProxies(at: $trusted);
        }

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
