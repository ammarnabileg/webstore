<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

try {
    $service = new App\Services\EvolutionApiService();
    $result = $service->sendMessage('96512345678', 'Test message');
    var_dump($result);
} catch (\Exception $e) {
    echo "Exception: " . $e->getMessage() . "\n";
}
