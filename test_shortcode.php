<?php
require __DIR__."/vendor/autoload.php";
$app = require_once __DIR__."/bootstrap/app.php";
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$content = "<p>hello</p> [site-features title1=\"Fast\"][/site-features] <p>text</p> [simple-slider key=\"123\"][/simple-slider]";
$blocks = [];
$shortcodes = shortcode()->getCompiler()->getRegistered();
foreach ($shortcodes as $key => $registered) {
    shortcode()->register($key, $registered["name"] ?? $key, $registered["description"] ?? "", function($shortcode) use (&$blocks, $key) {
        $blocks[] = [
            "type" => "shortcode",
            "name" => $key,
            "attributes" => $shortcode->toArray(),
        ];
        return "[[[SHORTCODE_BLOCK_" . (count($blocks) - 1) . "]]]";
    });
}
$html = shortcode()->compile($content);
echo json_encode(["html" => $html, "blocks" => $blocks]);

