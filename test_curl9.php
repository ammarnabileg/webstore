<?php
$ch = curl_init('https://brilliant-kw.com/products/8-mp-powered-by-darkfighter-fixed-dome-network-camera-ds-2cd2186g2h-isu28mmefo-stdblack');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_HEADER, true);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, false);
$res = curl_exec($ch);
$lines = explode("\n", $res);
foreach ($lines as $line) {
    if (stripos($line, 'location:') !== false) {
        echo $line;
    }
}
