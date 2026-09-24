<?php
require __DIR__.'/vendor/autoload.php';
\ = require_once __DIR__.'/bootstrap/app.php';
\ = \->make(Illuminate\Contracts\Http\Kernel::class);
\ = \->handle(Illuminate\Http\Request::capture());

\ = \Botble\SimpleSlider\Models\SimpleSliderItem::first();
if (\) {
    echo "Item attributes:\n";
    print_r(\->getAttributes());
    if (method_exists(\, 'getMetaData')) {
        echo "Metadata:\n";
        print_r(\->meta_boxes); // if they use meta box plugin
    }
} else {
    echo "No items found.";
}
