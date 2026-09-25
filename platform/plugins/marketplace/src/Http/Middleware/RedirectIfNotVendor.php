<?php

namespace Botble\Marketplace\Http\Middleware;

use Botble\Marketplace\Facades\MarketplaceHelper;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class RedirectIfNotVendor
{
    public function handle(Request $request, Closure $next, string $guard = 'customer')
    {
        if (! Auth::guard($guard)->check() || ! Auth::guard($guard)->user()->is_vendor) {
            if ($request->ajax() || $request->wantsJson()) {
                return response('Unauthorized.', 401);
            }

            return redirect()->guest(route('customer.login'));
        }

        if (MarketplaceHelper::getSetting('verify_vendor', true) &&
            ! Auth::guard($guard)->user()->vendor_verified_at) {
            if ($request->ajax() || $request->wantsJson()) {
                return response(trans('plugins/marketplace::marketplace.vendor_account_not_verified'), 403);
            }

            return redirect()->guest(route('marketplace.vendor.become-vendor'));
        }

        // A vendor with no store yet has store?->id === null; store-scoped queries then compare
        // against null and can match null-store / unscoped records. Require a real store before
        // any store-scoped vendor route runs.
        if (! Auth::guard($guard)->user()->store) {
            if ($request->ajax() || $request->wantsJson()) {
                return response(trans('plugins/marketplace::marketplace.vendor_account_not_verified'), 403);
            }

            return redirect()->guest(route('marketplace.vendor.become-vendor'));
        }

        return $next($request);
    }
}
