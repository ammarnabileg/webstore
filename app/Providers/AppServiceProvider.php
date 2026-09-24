<?php

namespace App\Providers;

use Illuminate\Cache\RateLimiting\Limit;
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
        $this->configureRateLimiting();

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
        RateLimiter::for('wizard-leads', fn (Request $request) => Limit::perMinutes(10, 5)->by($request->ip()));
        RateLimiter::for('wizard-events', fn (Request $request) => Limit::perMinute(60)->by($request->ip()));
    }
}
