<?php

$loader = require __DIR__ . '/../vendor/autoload.php';

// Botble registers plugin namespaces at runtime; unit tests load the ones they cover directly.
$loader->addPsr4('Botble\\SystemWizard\\', __DIR__ . '/../platform/plugins/system-wizard/src');
$loader->addPsr4('Botble\\SocialLogin\\', __DIR__ . '/../platform/plugins/social-login/src');

return $loader;
