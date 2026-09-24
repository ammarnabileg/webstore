<?php
require 'vendor/autoload.php';
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$service = app()->make('Botble\Klickpay\Services\Gateways\KlickpayPaymentService');
echo "Token: " . $service->getToken() . "\n";
$res = $service->execute([
    'amount' => 10,
    'currency' => 'KWD',
    'order_id' => '123',
    'callback_url' => 'http://localhost/test',
    'address' => []
]);
echo "URL: " . $res . "\n";
echo "Error: " . $service->getErrorMessage() . "\n";
