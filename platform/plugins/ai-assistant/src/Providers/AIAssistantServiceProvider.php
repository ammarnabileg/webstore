<?php

namespace Botble\AIAssistant\Providers;

use Botble\Base\Supports\ServiceProvider;
use Botble\Base\Traits\LoadAndPublishDataTrait;
use Botble\Base\Facades\Assets;
use Botble\Base\Facades\PanelSectionManager;
use Botble\Base\PanelSections\PanelSectionItem;
use Botble\Setting\PanelSections\SettingOthersPanelSection;
use Illuminate\Support\Facades\Auth;

class AIAssistantServiceProvider extends ServiceProvider
{
    use LoadAndPublishDataTrait;

    public function boot(): void
    {
        $this
            ->setNamespace('plugins/ai-assistant')
            ->loadAndPublishConfigurations(['general'])
            ->loadAndPublishTranslations()
            ->loadRoutes()
            ->loadAndPublishViews()
            ->publishAssets();

        // Inject AI buttons into Content Forms
        add_filter(BASE_FILTER_BEFORE_RENDER_FORM, function ($form, $data) {
            if (is_in_admin() && Auth::check()) {
                $model = get_class($data);
                if (in_array($model, [
                    'Botble\Ecommerce\Models\Product',
                    'Botble\Ecommerce\Models\ProductCategory',
                    'Botble\Blog\Models\Post',
                    'Botble\Page\Models\Page'
                ])) {
                    Assets::addScriptsDirectly('vendor/core/plugins/ai-assistant/js/ai-assistant.js')
                        ->addStylesDirectly('vendor/core/plugins/ai-assistant/css/ai-assistant.css');
                }
            }
            return $form;
        }, 120, 2);

        // Inject Floating AI Assistant Widget into Footer
        add_filter(BASE_FILTER_FOOTER_LAYOUT_TEMPLATE, function ($html) {
            if (is_in_admin() && Auth::check()) {
                Assets::addScriptsDirectly('vendor/core/plugins/ai-assistant/js/ai-assistant.js')
                    ->addStylesDirectly('vendor/core/plugins/ai-assistant/css/ai-assistant.css');
                
                try {
                    return $html . view('plugins/ai-assistant::partials.assistant-widget')->render();
                } catch (\Exception $e) {
                    return $html;
                }
            }
            return $html;
        }, 1100);

        PanelSectionManager::default()->beforeRendering(function (): void {
            PanelSectionManager::registerItem(
                SettingOthersPanelSection::class,
                fn () => PanelSectionItem::make('ai-assistant')
                    ->setTitle('AI Assistant Settings')
                    ->withIcon('ti ti-robot')
                    ->withDescription('Configure OpenRouter API for AI assistance.')
                    ->withPriority(1000)
                    ->withRoute('ai-assistant.settings')
            );
        });
    }
}
