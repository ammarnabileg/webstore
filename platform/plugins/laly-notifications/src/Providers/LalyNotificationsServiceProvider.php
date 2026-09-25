<?php

namespace Botble\LalyNotifications\Providers;

use Botble\Base\Facades\DashboardMenu;
use Botble\Base\Supports\ServiceProvider;
use Botble\Base\Traits\LoadAndPublishDataTrait;
use Botble\Ecommerce\Models\ProductCategory;
use Botble\Ecommerce\Models\ProductCollection;
use Botble\LalyNotifications\Commands\SendScheduledNotificationsCommand;
use Botble\LalyNotifications\Models\Notification;
use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\RateLimiter;

class LalyNotificationsServiceProvider extends ServiceProvider
{
    use LoadAndPublishDataTrait;

    public function boot(): void
    {
        if (! is_plugin_active('ecommerce')) {
            return;
        }

        $this
            ->setNamespace('plugins/laly-notifications')
            ->loadHelpers()
            ->loadAndPublishConfigurations(['general', 'permissions'])
            ->loadAndPublishTranslations()
            ->loadAndPublishViews()
            ->loadMigrations()
            ->loadRoutes();

        // Push-token registration runs on page loads of the PWA; keep it off other counters.
        RateLimiter::for('fcm-token', fn (Request $request) => Limit::perMinute(20)->by($request->ip()));

        DashboardMenu::default()->beforeRetrieving(function (): void {
            DashboardMenu::make()
                ->registerItem([
                    'id' => 'cms-plugins-laly-notifications',
                    'priority' => 90,
                    'parent_id' => 'cms-plugins-ecommerce',
                    'name' => 'plugins/laly-notifications::notifications.notifications',
                    'icon' => 'ti ti-bell',
                    'url' => fn () => route('laly-notifications.index'),
                    'permissions' => ['laly-notifications.index'],
                ])
                ->registerItem([
                    'id' => 'cms-plugins-laly-notifications-settings',
                    'priority' => 91,
                    'parent_id' => 'cms-plugins-ecommerce',
                    'name' => 'plugins/laly-notifications::notifications.settings',
                    'icon' => 'ti ti-brand-firebase',
                    'url' => fn () => route('laly-notifications.settings'),
                    'permissions' => ['laly-notifications.settings'],
                ]);
        });

        // A deleted category/collection must not leave notifications pointing at it.
        ProductCategory::deleted(function (ProductCategory $category): void {
            Notification::query()->where('target_type', 'category')->where('target_id', $category->id)
                ->update(['target_type' => 'none', 'target_id' => null]);
        });

        ProductCollection::deleted(function (ProductCollection $collection): void {
            Notification::query()->where('target_type', 'collection')->where('target_id', $collection->id)
                ->update(['target_type' => 'none', 'target_id' => null]);
        });

        if ($this->app->runningInConsole()) {
            $this->commands([SendScheduledNotificationsCommand::class]);

            $this->app->afterResolving(Schedule::class, function (Schedule $schedule): void {
                $schedule->command(SendScheduledNotificationsCommand::class)->everyMinute()->withoutOverlapping();
            });
        }
    }
}
