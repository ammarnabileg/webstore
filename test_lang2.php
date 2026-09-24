<?php
require 'bootstrap/autoload.php';
\ = require_once 'bootstrap/app.php';
\ = \->make(Illuminate\Contracts\Http\Kernel::class);
\ = \->handle(Illuminate\Http\Request::capture());

if (is_plugin_active('language')) {
    echo "Language active\n";
    print_r(Language::getSupportedLocales());
} else {
    echo "Language not active";
}
