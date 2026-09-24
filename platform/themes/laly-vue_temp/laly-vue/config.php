<?php

use Botble\Theme\Theme;

return [
    'inherit' => null,
    'events' => [
        'beforeRenderTheme' => function (Theme $theme) {
            $theme->asset()->usePath()->add('app-css', 'css/app.css');
            $theme->asset()->container('footer')->usePath()->add('app-js', 'js/app.js');
        },
    ],
];
