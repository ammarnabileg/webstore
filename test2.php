<?php
use Botble\Ecommerce\Repositories\Interfaces\ProductInterface;
\ = app(ProductInterface::class);
\ = [
    'paginate' => [
        'per_page' => 10,
        'current_paged' => 1,
    ],
    'with' => ['slugable'],
];
\ = [];
try {
    \ = \->getProducts(\, \);
    echo 'Success';
} catch (\Throwable \) {
    echo 'Error: ' . \->getMessage() . ' in ' . \->getFile() . ':' . \->getLine();
}
