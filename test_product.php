<?php
$product = \Botble\Ecommerce\Models\Product::where('name', 'like', '%AX1800%')->first();
if ($product) {
    echo "ID: " . $product->id . "\n";
    echo "Status: " . $product->status->getValue() . "\n";
    $slug = \Botble\Slug\Models\Slug::where('reference_id', $product->id)->where('reference_type', \Botble\Ecommerce\Models\Product::class)->first();
    echo "Slug: " . ($slug ? $slug->key : 'None') . "\n";
} else {
    echo "Product not found.\n";
}
