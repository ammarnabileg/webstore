<?php

use Botble\Theme\Theme;

return [
    'inherit' => 'martfury',
    'events' => [
        'beforeRenderTheme' => function (Theme $theme) {
            // Registered with an explicit themes/laly-vue path: with 'inherit' => 'martfury', usePath()
            // resolves to the parent theme's folder. Names are unique so martfury's own 'app-js'
            // does not replace ours. Versioned by build time so browsers can cache the bundle.
            $version = static fn (string $file) => (string) (@filemtime(__DIR__ . '/public/' . $file) ?: '1');

            $theme->asset()->add('laly-vue-app-css', 'themes/laly-vue/css/app.css', [], [], $version('css/app.css'));
            $theme->asset()->container('footer')->add('laly-vue-app-js', 'themes/laly-vue/js/app.js', [], [], $version('js/app.js'));
        },
    ],
];
