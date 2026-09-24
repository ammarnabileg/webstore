<?php
$dir = 'platform/plugins/klickpay';
$iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($dir));
foreach ($iterator as $file) {
    if ($file->isFile() && $file->getExtension() === 'php') {
        $content = file_get_contents($file->getPathname());
        $content = str_replace(
            ['namespace Botble\klickpay', 'class klickpay', 'use Botble\klickpay', '\klickpayPaymentService', '\klickpayPaymentMethodForm', '\klickpayController', 'klickpayServiceProvider', 'Botble\\klickpay'], 
            ['namespace Botble\Klickpay', 'class Klickpay', 'use Botble\Klickpay', '\KlickpayPaymentService', '\KlickpayPaymentMethodForm', '\KlickpayController', 'KlickpayServiceProvider', 'Botble\\Klickpay'], 
            $content
        );
        file_put_contents($file->getPathname(), $content);
        
        // Also rename the file if it has lowercase klickpay at the start
        $filename = $file->getFilename();
        if (str_starts_with($filename, 'klickpay')) {
            $newFilename = 'Klickpay' . substr($filename, 8);
            rename($file->getPathname(), $file->getPath() . '/' . $newFilename);
        }
    }
}
$pluginJson = file_get_contents($dir . '/plugin.json');
$pluginJson = str_replace('Botble\\klickpay', 'Botble\\Klickpay', $pluginJson);
file_put_contents($dir . '/plugin.json', $pluginJson);
echo "Fixed!";
