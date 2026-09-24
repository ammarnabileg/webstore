<?php

if (!function_exists('pwa_enabled')) {
    /**
     * Check if PWA is enabled
     */
    function pwa_enabled(): bool
    {
        return (bool) setting('pwa_enabled', false);
    }
}

if (!function_exists('pwa_meta_tags')) {
    /**
     * Generate PWA meta tags for theme header
     */
    function pwa_meta_tags(): string
    {
        if (!pwa_enabled()) {
            return '';
        }

        $themeColor = setting('pwa_theme_color', '#6366f1');
        $bgColor = setting('pwa_background_color', '#ffffff');
        $appName = setting('pwa_name', config('app.name'));

        return <<<HTML

<!-- PWA Meta Tags -->
<meta name="theme-color" content="{$themeColor}">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="default">
<meta name="apple-mobile-web-app-title" content="{$appName}">
<meta name="mobile-web-app-capable" content="yes">
<link rel="manifest" href="/manifest.json">
<link rel="apple-touch-icon" href="/storage/pwa-icon-192.png">
<link rel="icon" type="image/png" sizes="192x192" href="/storage/pwa-icon-192.png">
<link rel="icon" type="image/png" sizes="512x512" href="/storage/pwa-icon-512.png">
<!-- End PWA Meta Tags -->

HTML;
    }
}

if (!function_exists('pwa_service_worker')) {
    /**
     * Generate service worker registration script
     */
    function pwa_service_worker(): string
    {
        if (!pwa_enabled()) {
            return '';
        }

        return <<<HTML

<!-- PWA Service Worker Registration -->
<script>
if ('serviceWorker' in navigator) {
    window.addEventListener('load', function() {
        navigator.serviceWorker.register('/service-worker.js')
            .then(function(registration) {
                console.log('✓ PWA Service Worker registered successfully');
                console.log('Scope:', registration.scope);
                
                // Check for updates
                registration.addEventListener('updatefound', function() {
                    console.log('PWA: New version available');
                });
            })
            .catch(function(error) {
                console.log('✗ PWA Service Worker registration failed:', error);
            });
    });

    // Reload page when new service worker takes control
    navigator.serviceWorker.addEventListener('controllerchange', function() {
        if (!window.pwaSWReloaded) {
            window.pwaSWReloaded = true;
            window.location.reload();
        }
    });
}
</script>
<!-- End PWA Service Worker -->

HTML;
    }
}