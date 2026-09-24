<?php
require 'vendor/autoload.php';
$app = require_once 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();
\Botble\Theme\Events\RenderingThemeOptionSettings::dispatch();
echo json_encode([
    'logo_is_shared' => \Botble\Theme\Facades\ThemeOption::isFieldShared('logo'),
    'favicon_is_shared' => \Botble\Theme\Facades\ThemeOption::isFieldShared('favicon')
]);
