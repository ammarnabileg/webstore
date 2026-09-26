<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Headers Botble's HttpSecurityHeaders does not send (it only sets nosniff, frame options,
 * XSS protection and referrer policy, and only on the web group).
 *
 * The CSP starts in Report-Only mode: it lists the third parties the storefront really
 * uses, and should be switched to enforcing (SECURITY_CSP_ENFORCE=true) only after the
 * browser console shows no violations on the live site.
 */
class SecurityHeaders
{
    public function handle(Request $request, Closure $next): Response
    {
        $response = $next($request);

        if (function_exists('header_remove')) {
            header_remove('X-Powered-By');
        }
        $response->headers->remove('X-Powered-By');

        if ($request->isSecure()) {
            $response->headers->set('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');
        }

        $response->headers->set('Permissions-Policy', 'camera=(), microphone=(), geolocation=(), payment=(self)');

        if (! $response->headers->has('Content-Security-Policy') && ! $this->isAdmin($request)) {
            $header = config('app.csp_enforce') ? 'Content-Security-Policy' : 'Content-Security-Policy-Report-Only';
            $response->headers->set($header, $this->policy());
        }

        return $response;
    }

    protected function isAdmin(Request $request): bool
    {
        $prefix = trim((string) config('core.base.general.admin_dir', 'admin'), '/');

        return $prefix !== '' && ($request->is($prefix) || $request->is($prefix . '/*'));
    }

    protected function policy(): string
    {
        return implode('; ', [
            "default-src 'self'",
            // Botble layouts rely on inline scripts (window.BotbleData, theme options).
            "script-src 'self' 'unsafe-inline' https://widget.deema.me https://sandbox-widget.deema.me https://cdn.jsdelivr.net https://www.gstatic.com https://www.google.com https://www.recaptcha.net",
            "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com https://cdn.jsdelivr.net",
            "font-src 'self' data: https://fonts.gstatic.com https://cdn.jsdelivr.net",
            "img-src 'self' data: blob: https:",
            "connect-src 'self' https://*.deema.me https://*.taly.io https://*.googleapis.com https://www.google.com",
            "frame-src 'self' https://*.deema.me https://*.taly.io https://www.google.com https://www.recaptcha.net",
            "object-src 'none'",
            "base-uri 'self'",
            "form-action 'self' https://*.klick-pay.com https://*.deema.me https://*.taly.io",
            "frame-ancestors 'self'",
        ]);
    }
}
