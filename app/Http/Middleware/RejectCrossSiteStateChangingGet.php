<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * A few state-changing routes are exposed as GET (logout, cart remove/destroy, address delete),
 * which a cross-site page could trigger via an <img>/<a> (CSRF-style logout, cart tampering).
 * This rejects such GETs when the request is unambiguously cross-site: a `Sec-Fetch-Site: cross-site`
 * header, or a Referer whose host differs from the app host. Same-site requests and direct
 * navigations (no Referer, no Sec-Fetch metadata) are allowed so normal use is unaffected.
 */
class RejectCrossSiteStateChangingGet
{
    public function handle(Request $request, Closure $next): Response
    {
        if ($request->isMethod('GET') && $this->isStateChangingGet($request)) {
            $fetchSite = $request->header('Sec-Fetch-Site');
            $referer = $request->headers->get('referer');
            $refererHost = $referer ? parse_url($referer, PHP_URL_HOST) : null;

            $crossSite = ($fetchSite && ! in_array($fetchSite, ['same-origin', 'same-site', 'none'], true))
                || ($refererHost && ! hash_equals($request->getHost(), (string) $refererHost));

            if ($crossSite) {
                abort(403, 'Cross-site request rejected.');
            }
        }

        return $next($request);
    }

    protected function isStateChangingGet(Request $request): bool
    {
        $path = ltrim($request->path(), '/');
        // Strip an optional leading locale segment (e.g. en/logout).
        $path = preg_replace('#^[a-z]{2}(-[A-Za-z]{2})?/#', '', $path);

        return $path === 'logout'
            || $path === 'cart/destroy'
            || str_starts_with($path, 'cart/remove/')
            || str_starts_with($path, 'cart/add/')
            || str_starts_with($path, 'customer/address/delete/');
    }
}
