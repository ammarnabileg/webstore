<?php
require __DIR__.'/vendor/autoload.php';
\ = require_once __DIR__.'/bootstrap/app.php';
\ = \->make(Illuminate\Contracts\Http\Kernel::class);
\ = \->handle(Illuminate\Http\Request::capture());

if (is_plugin_active('simple-slider')) {
    \ = \Botble\SimpleSlider\Models\SimpleSlider::with(['sliderItems' => function (\) {
        \->orderBy('order', 'ASC');
    }])->where('status', 'published')->get();
    echo json_encode(\);
}
