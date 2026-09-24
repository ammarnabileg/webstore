<?php

namespace App\Providers;

use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Http\Middleware\TrustProxies;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        $this->configureTrustedProxies();
        $this->configureRateLimiting();
        $this->guardCustomerPhoneIdentity();

        \Event::listen(\Illuminate\Routing\Events\RouteMatched::class, function () {
            if (class_exists(\Botble\Base\Facades\DashboardMenu::class)) {
                \Botble\Base\Facades\DashboardMenu::registerItem([
                    'id' => 'cms-plugins-whatsapp-marketing',
                    'priority' => 10,
                    'parent_id' => null,
                    'name' => 'WhatsApp Marketing',
                    'icon' => 'ti ti-brand-whatsapp',
                    'url' => route('whatsapp.marketing.index'),
                    'permissions' => ['customers.edit'],
                ]);
            }
        });
    }

    /**
     * WhatsApp login trusts ec_customers.phone_verified_at, so a customer must not be able to
     * move a verified flag onto someone else's number, or claim the placeholder email domain
     * the OTP flow uses to recognise its own accounts.
     */
    protected function guardCustomerPhoneIdentity(): void
    {
        if (! class_exists(\Botble\Ecommerce\Models\Customer::class)) {
            return;
        }

        \Botble\Ecommerce\Models\Customer::saving(function ($customer): void {
            if ($customer->isDirty('phone') && ! $customer->isDirty('phone_verified_at')) {
                $customer->phone_verified_at = null;
            }

            if ($customer->isDirty('email')
                && str_ends_with(strtolower((string) $customer->email), '@whatsapp.local')
                && ! \App\Http\Controllers\WhatsAppAuthController::$creatingPlaceholderAccount) {
                throw \Illuminate\Validation\ValidationException::withMessages([
                    'email' => __('validation.email', ['attribute' => 'email']),
                ]);
            }
        });
    }

    protected function configureTrustedProxies(): void
    {
        $trusted = array_values(array_filter(array_map('trim', explode(',', (string) config('app.trusted_proxies')))));

        if ($trusted) {
            TrustProxies::at($trusted);
        }
    }

    /**
     * Named limiters: plain "throttle:N,M" shares one counter per IP across every route
     * that uses it, so e.g. wizard analytics events used up the lead-submission limit.
     */
    protected function configureRateLimiting(): void
    {
        $byUserOrIp = fn (Request $request) => $request->user()?->getAuthIdentifier() ?: $request->ip();

        RateLimiter::for('admin-tools', fn (Request $request) => Limit::perMinute(10)->by($byUserOrIp($request)));
        RateLimiter::for('whatsapp-auth', fn (Request $request) => Limit::perMinute(10)->by($request->ip()));
        RateLimiter::for('webhooks', fn (Request $request) => Limit::perMinute(120)->by($request->ip()));
        RateLimiter::for('payment-return', fn (Request $request) => Limit::perMinute(30)->by($request->ip()));
        RateLimiter::for('order-tracking', fn (Request $request) => Limit::perMinute(10)->by($request->ip()));
        // By IP: a session id is free to rotate (drop the cookie), so it would not limit anything.
        RateLimiter::for('coupon', fn (Request $request) => Limit::perMinute(10)->by($request->ip()));
        RateLimiter::for('public-forms', fn (Request $request) => Limit::perMinute(5)->by($request->ip()));
        // Push-token registration runs on every page load of the PWA; keep it off the forms counter.
        RateLimiter::for('fcm-token', fn (Request $request) => Limit::perMinute(20)->by($request->ip()));

        // Stock Botble routes that ship without any throttle: order tracking (code + email
        // brute force to read order details), coupon codes (brute force), contact/newsletter (spam).
        $this->app->booted(function (): void {
            $limits = [
                'public.orders.tracking' => 'order-tracking',
                'public.coupon.apply' => 'coupon',
                'public.send.contact' => 'public-forms',
                'public.newsletter.subscribe' => 'public-forms',
            ];

            $routes = app('router')->getRoutes();
            $routes->refreshNameLookups();

            foreach ($limits as $name => $limiter) {
                $routes->getByName($name)?->middleware('throttle:' . $limiter);
            }

            // Same endpoints in the (unnamed) ecommerce API, in case api_enabled is ever turned on.
            $apiLimits = [
                'api/v1/ecommerce/coupon/apply' => 'coupon',
                'api/v1/ecommerce/orders/tracking' => 'order-tracking',
            ];

            foreach ($routes->getRoutes() as $route) {
                if (isset($apiLimits[$route->uri()]) && in_array('POST', $route->methods(), true)) {
                    $route->middleware('throttle:' . $apiLimits[$route->uri()]);
                }
            }
        });
        RateLimiter::for('wizard-leads', fn (Request $request) => Limit::perMinutes(10, 5)->by($request->ip()));
        RateLimiter::for('wizard-events', fn (Request $request) => Limit::perMinute(60)->by($request->ip()));
    }
}
