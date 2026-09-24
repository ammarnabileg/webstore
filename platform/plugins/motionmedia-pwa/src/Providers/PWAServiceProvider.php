<?php

namespace Botble\PWA\Providers;

use Botble\Base\Supports\ServiceProvider;
use Botble\Base\Traits\LoadAndPublishDataTrait;
use Illuminate\Routing\Events\RouteMatched;
use Illuminate\Support\Facades\File;
use Throwable;

class PWAServiceProvider extends ServiceProvider
{
    use LoadAndPublishDataTrait;

    public function register()
    {
        // Load helpers
        $helperFile = plugin_path('pwa/helpers/helpers.php');
        if (File::exists($helperFile)) {
            require_once $helperFile;
        }
    }

    public function boot()
    {
        try {
            $this->setNamespace('plugins/pwa')
                ->loadAndPublishViews()
                ->loadRoutes(['web']);

            $this->app['events']->listen(RouteMatched::class, function () {
                try {
                    dashboard_menu()->registerItem([
                        'id' => 'cms-plugins-pwa',
                        'priority' => 5,
                        'parent_id' => 'cms-core-settings',
                        'name' => 'PWA Settings',
                        'icon' => 'fa fa-mobile',
                        'url' => route('pwa.settings'),
                        'permissions' => ['settings.options'],
                    ]);
                } catch (Throwable $e) {
                    // Silent fail if menu registration fails
                }
            });

            // Add PWA meta tags to theme header
            add_filter('theme_header_meta', function ($html) {
                if (function_exists('pwa_enabled') && pwa_enabled()) {
                    return $html . pwa_meta_tags();
                }
                return $html;
            }, 100);
            
            // Add service worker registration to footer
            add_filter('theme_footer', function ($html) {
                if (function_exists('pwa_enabled') && pwa_enabled()) {
                    return $html . pwa_service_worker();
                }
                return $html;
            }, 100);

            // Auto-create default icons if they don't exist
            $this->createDefaultIcons();
        } catch (Throwable $e) {
            // Log error but don't break site
            if (function_exists('info')) {
                info('PWA Plugin Error: ' . $e->getMessage());
            }
        }
    }

    protected function createDefaultIcons()
    {
        try {
            $publicPath = public_path('storage');
            
            if (!File::exists($publicPath)) {
                File::makeDirectory($publicPath, 0755, true);
            }

            // Create simple default icons if they don't exist
            $icon192 = $publicPath . '/pwa-icon-192.png';
            $icon512 = $publicPath . '/pwa-icon-512.png';

            if (!File::exists($icon192)) {
                $this->createDefaultIcon($icon192, 192);
            }

            if (!File::exists($icon512)) {
                $this->createDefaultIcon($icon512, 512);
            }
        } catch (Throwable $e) {
            // Silent fail for icon creation
        }
    }

    protected function createDefaultIcon($path, $size)
    {
        try {
            // Check if GD library is available
            if (!function_exists('imagecreatetruecolor')) {
                return;
            }

            // Create a simple colored square as default icon
            $image = imagecreatetruecolor($size, $size);
            $bgColor = imagecolorallocate($image, 99, 102, 241); // Purple color
            $textColor = imagecolorallocate($image, 255, 255, 255);
            
            imagefill($image, 0, 0, $bgColor);
            
            // Add text "PWA"
            $text = "PWA";
            
            // Use built-in font
            $x = ($size - (strlen($text) * 8)) / 2;
            $y = $size / 2;
            imagestring($image, 5, $x, $y, $text, $textColor);
            
            imagepng($image, $path);
            imagedestroy($image);
        } catch (Throwable $e) {
            // Silent fail for icon creation
        }
    }
}