<?php

use Botble\Ecommerce\Models\Product;

add_action(BASE_ACTION_META_BOXES, function ($context, $object) {
    $class = is_object($object) ? get_class($object) : (is_string($object) ? $object : null);
    if ($class == Product::class && $context == 'advanced') {
        MetaBox::addMetaBox('bnpl_meta_boxes', 'BNPL Integrations', function () use ($object) {
            $acceptsTaly = MetaBox::getMetaData($object, 'accepts_taly', true);
            $acceptsDeema = MetaBox::getMetaData($object, 'accepts_deema', true);

            echo '<div class="form-group mb-3">';
            echo '<label class="control-label">Accepts Taly (BNPL)</label>';
            echo '<div class="mt-checkbox-list">';
            echo '<label class="mt-checkbox mt-checkbox-outline">';
            echo '<input type="checkbox" name="accepts_taly" value="1" ' . ($acceptsTaly == 1 ? 'checked' : '') . '> Yes';
            echo '<span></span>';
            echo '</label>';
            echo '</div>';
            echo '</div>';

            echo '<div class="form-group mb-3">';
            echo '<label class="control-label">Accepts Deema (BNPL)</label>';
            echo '<div class="mt-checkbox-list">';
            echo '<label class="mt-checkbox mt-checkbox-outline">';
            echo '<input type="checkbox" name="accepts_deema" value="1" ' . ($acceptsDeema == 1 ? 'checked' : '') . '> Yes';
            echo '<span></span>';
            echo '</label>';
            echo '</div>';
            echo '</div>';
        }, $class, $context);
    }
}, 120, 2);

add_action(BASE_ACTION_AFTER_CREATE_CONTENT, function ($type, $request, $object) {
    $class = is_object($object) ? get_class($object) : null;
    if ($class == Product::class) {
        $acceptsTaly = $request->input('accepts_taly', 0);
        $acceptsDeema = $request->input('accepts_deema', 0);
        MetaBox::saveMetaBoxData($object, 'accepts_taly', $acceptsTaly);
        MetaBox::saveMetaBoxData($object, 'accepts_deema', $acceptsDeema);
    }
}, 120, 3);

add_action(BASE_ACTION_AFTER_UPDATE_CONTENT, function ($type, $request, $object) {
    $class = is_object($object) ? get_class($object) : null;
    if ($class == Product::class) {
        $acceptsTaly = $request->input('accepts_taly', 0);
        $acceptsDeema = $request->input('accepts_deema', 0);
        MetaBox::saveMetaBoxData($object, 'accepts_taly', $acceptsTaly);
        MetaBox::saveMetaBoxData($object, 'accepts_deema', $acceptsDeema);
    }
}, 120, 3);
