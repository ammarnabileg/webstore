<?php

namespace App\Providers;

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
        \Event::listen(\Illuminate\Routing\Events\RouteMatched::class, function () {
            if (class_exists(\Botble\Base\Facades\DashboardMenu::class)) {
                \Botble\Base\Facades\DashboardMenu::registerItem([
                    'id' => 'cms-plugins-whatsapp-marketing',
                    'priority' => 10,
                    'parent_id' => null,
                    'name' => 'WhatsApp Marketing',
                    'icon' => 'ti ti-brand-whatsapp',
                    'url' => route('whatsapp.marketing.index'),
                    'permissions' => [],
                ]);
            }
        });
    }
}
