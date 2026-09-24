<?php
use Botble\Ecommerce\Repositories\Interfaces\ProductInterface;
$productRepository = app(ProductInterface::class);
$params = [
    'paginate' => [
        'per_page' => 10,
        'current_paged' => 1,
    ],
    'with' => ['slugable'],
];
$filters = [];
try {
    $products = $productRepository->getProducts($params, $filters);
    echo 'Success. Count: ' . count($products);
} catch (\Throwable $e) {
    echo 'Error: ' . $e->getMessage() . ' in ' . $e->getFile() . ':' . $e->getLine();
}
