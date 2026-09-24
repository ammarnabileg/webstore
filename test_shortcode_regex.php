<?php
require __DIR__."/vendor/autoload.php";
$app = require_once __DIR__."/bootstrap/app.php";
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$content = "<p>Welcome</p> [site-features title1=\"Fast\"][/site-features] <div>text</div> [simple-slider key=\"123\"][/simple-slider]";

// Get Botble shortcode regex
// We must invoke getRegex using reflection because it is protected!
$compiler = shortcode()->getCompiler();
$reflection = new ReflectionClass($compiler);
$method = $reflection->getMethod("getRegex");
$method->setAccessible(true);
$pattern = "/" . $method->invoke($compiler) . "/s";

preg_match_all($pattern, $content, $matches, PREG_OFFSET_CAPTURE);

$blocks = [];
$lastOffset = 0;

foreach ($matches as $match) {
    $fullMatch = $match[0][0];
    $offset = $match[0][1];
    $name = $match[2][0]; // Name is typically group 2 in Botble regex
    
    // Add raw HTML before this shortcode
    if ($offset > $lastOffset) {
        $html = substr($content, $lastOffset, $offset - $lastOffset);
        if (trim(strip_tags($html)) !== "" || trim($html) !== "") {
            $blocks[] = ["type" => "html", "content" => trim($html)];
        }
    }
    
    $attributes = $compiler->getAttributes($fullMatch);
    
    $blocks[] = [
        "type" => "shortcode",
        "name" => $name,
        "attributes" => $attributes,
    ];
    
    $lastOffset = $offset + strlen($fullMatch);
}

// Add remaining HTML
if ($lastOffset < strlen($content)) {
    $html = substr($content, $lastOffset);
    if (trim(strip_tags($html)) !== "" || trim($html) !== "") {
        $blocks[] = ["type" => "html", "content" => trim($html)];
    }
}

echo json_encode($blocks);

