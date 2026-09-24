<?php
$ch = curl_init('https://brilliant-kw.com/ajax/vue/product-categories');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
$res = curl_exec($ch);
echo substr($res, 0, 1500);
