<?php
$ch = curl_init('https://brilliant-kw.com/en/ajax/vue/categories');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_HTTPHEADER, ['X-Requested-With: XMLHttpRequest']);
$res = curl_exec($ch);
echo substr($res, 0, 1500);
