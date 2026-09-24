<?php
require __DIR__.'/vendor/autoload.php';
\ = require_once __DIR__.'/bootstrap/app.php';
\ = \->make(Illuminate\Contracts\Http\Kernel::class);
\ = \->handle(Illuminate\Http\Request::capture());

\ = \Botble\SimpleSlider\Models\SimpleSlider::with(['sliderItems' => function(\) {
    \->orderBy('order', 'ASC');
}])->where('id', 1)->first();

if (\ && \->sliderItems) {
    echo "Total slider items for slider 1: " . \->sliderItems->count() . "\n";
    foreach (\->sliderItems as \) {
        echo "- " . \->title . " (Status: " . \->status . ")\n";
    }
} else {
    echo "Slider not found or no items.";
}
