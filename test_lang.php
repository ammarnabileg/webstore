<?php
require 'bootstrap/autoload.php';
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);
$response = $kernel->handle(Illuminate\Http\Request::capture());

if (is_plugin_active('language')) {
    echo "Language active\n";
    print_r(Language::getSupportedLocales());
} else {
    echo "Language not active";
}
