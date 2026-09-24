<?php

namespace Botble\SystemWizard\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Event;
use Illuminate\Routing\Events\RouteMatched;
use Botble\Base\Traits\LoadAndPublishDataTrait;
use DashboardMenu;

class SystemWizardServiceProvider extends ServiceProvider
{
    use LoadAndPublishDataTrait;

    public function register()
    {
        // 
    }

    public function boot()
    {
        $this->setNamespace('plugins/system-wizard')
            ->loadAndPublishViews()
            ->loadAndPublishTranslations()
            ->loadRoutes();

        Event::listen(RouteMatched::class, function () {
            DashboardMenu::registerItem([
                'id'          => 'cms-plugins-system-wizard',
                'priority'    => 5,
                'parent_id'   => null,
                'name'        => 'طلبات اعرف نظامك',
                'icon'        => 'ti ti-device-cctv',
                'url'         => route('system-wizard.index'),
                'permissions' => ['system-wizard.index'],
            ])->registerItem([
                'id'          => 'cms-plugins-system-wizard-leads',
                'priority'    => 1,
                'parent_id'   => 'cms-plugins-system-wizard',
                'name'        => 'الطلبات الواردة',
                'icon'        => null,
                'url'         => route('system-wizard.index'),
                'permissions' => ['system-wizard.index'],
            ])->registerItem([
                'id'          => 'cms-plugins-system-wizard-settings',
                'priority'    => 2,
                'parent_id'   => 'cms-plugins-system-wizard',
                'name'        => 'إعدادات المنتجات',
                'icon'        => null,
                'url'         => route('system-wizard.settings'),
                'permissions' => ['system-wizard.settings'],
            ]);
        });
    }
}
