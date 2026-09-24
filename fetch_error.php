<?php
$url = "https://brilliant-kw.com/en/ajax/vue/products/4-mp-acusense-fixed-turret-network-camera-ds-2cd2346g2-iu28mmcblack";
$opts = [
    "http" => [
        "method" => "GET",
        "header" => "Accept: application/json\r\n",
        "ignore_errors" => true
    ],
    "ssl" => [
        "verify_peer" => false,
        "verify_peer_name" => false
    ]
];
$context = stream_context_create($opts);
$result = file_get_contents($url, false, $context);
echo $result;
