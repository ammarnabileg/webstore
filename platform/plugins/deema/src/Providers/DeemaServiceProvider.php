<?php

namespace Botble\Deema\Providers;

use Botble\Base\Traits\LoadAndPublishDataTrait;
use Illuminate\Support\ServiceProvider;

class DeemaServiceProvider extends ServiceProvider
{
    use LoadAndPublishDataTrait;

    public function register()
    {
        $this->setNamespace('plugins/deema')
            ;
    }

    public function boot()
    {
        $this->setNamespace('plugins/deema')
            ->loadAndPublishConfigurations(['permissions'])
            ->loadAndPublishTranslations()
            ->loadAndPublishViews()
            ->loadRoutes(['web', 'api']);

        if (defined('PAYMENT_FILTER_ADDITIONAL_PAYMENT_METHODS')) {
            $this->app->register(HookServiceProvider::class);
        }
    }
}
