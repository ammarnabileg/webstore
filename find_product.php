<?php

use Illuminate\Support\Facades\DB;

$product = DB::table('ec_products')->where('name', 'like', '%AX1800%')->first();
if ($product) {
    echo "Product ID: {$product->id}\n";
    echo "Name: {$product->name}\n";
    echo "Status: {$product->status}\n";
    echo "Stock Status: {$product->stock_status}\n";
    
    $slug = DB::table('slugs')
        ->where('reference_id', $product->id)
        ->where('reference_type', 'Botble\Ecommerce\Models\Product')
        ->first();
        
    echo "Slug: " . ($slug ? $slug->key : 'None') . "\n";
} else {
    echo "Not found.\n";
}
