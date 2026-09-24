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
$products = $productRepository->getProducts($params, $filters);
echo 'Products count: ' . count($products);
