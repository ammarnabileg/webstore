<?php
require __DIR__.'/vendor/autoload.php';
\ = require_once __DIR__.'/bootstrap/app.php';
\ = \->make(Illuminate\Contracts\Http\Kernel::class);
\ = \->handle(Illuminate\Http\Request::capture());

\ = \Botble\SimpleSlider\Models\SimpleSlider::with(['sliderItems'])->where('id', 1)->first();
if (\) {
    echo "Slider items count: " . \->sliderItems->count() . "\n";
    foreach (\->sliderItems as \) {
        echo \->title . " | Status: " . \->status . "\n";
    }
}
