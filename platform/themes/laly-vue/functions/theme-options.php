<?php

app()->booted(function () {
    theme_option()
        ->setSection([
            'title' => 'Mobile Onboarding (Splash)',
            'desc' => 'Theme options for Mobile Onboarding Splash Screen. You can translate these by switching languages in the admin panel.',
            'id' => 'opt-text-subsection-onboarding',
            'subsection' => true,
            'icon' => 'ti ti-device-mobile',
        ])
        
        // Slide 1
        ->setField([
            'id' => 'intro_title_1',
            'section_id' => 'opt-text-subsection-onboarding',
            'type' => 'text',
            'label' => 'Slide 1 Title',
            'attributes' => [
                'name' => 'intro_title_1',
                'value' => 'تسوق بسهولة',
                'options' => [
                    'class' => 'form-control',
                ],
            ],
        ])
        ->setField([
            'id' => 'intro_desc_1',
            'section_id' => 'opt-text-subsection-onboarding',
            'type' => 'textarea',
            'label' => 'Slide 1 Description',
            'attributes' => [
                'name' => 'intro_desc_1',
                'value' => 'اكتشف آلاف المنتجات بأسعار تنافسية وتجربة تسوق لا مثيل لها.',
                'options' => [
                    'class' => 'form-control',
                    'rows' => 3,
                ],
            ],
        ])
        ->setField([
            'id' => 'intro_icon_1',
            'section_id' => 'opt-text-subsection-onboarding',
            'type' => 'text',
            'label' => 'Slide 1 Icon (e.g. ti ti-shopping-cart)',
            'attributes' => [
                'name' => 'intro_icon_1',
                'value' => 'ti ti-shopping-cart',
                'options' => [
                    'class' => 'form-control',
                ],
            ],
        ])
        
        // Slide 2
        ->setField([
            'id' => 'intro_title_2',
            'section_id' => 'opt-text-subsection-onboarding',
            'type' => 'text',
            'label' => 'Slide 2 Title',
            'attributes' => [
                'name' => 'intro_title_2',
                'value' => 'توصيل سريع',
                'options' => [
                    'class' => 'form-control',
                ],
            ],
        ])
        ->setField([
            'id' => 'intro_desc_2',
            'section_id' => 'opt-text-subsection-onboarding',
            'type' => 'textarea',
            'label' => 'Slide 2 Description',
            'attributes' => [
                'name' => 'intro_desc_2',
                'value' => 'نوفر لك خيارات توصيل سريعة وموثوقة لجميع أنحاء البلاد.',
                'options' => [
                    'class' => 'form-control',
                    'rows' => 3,
                ],
            ],
        ])
        ->setField([
            'id' => 'intro_icon_2',
            'section_id' => 'opt-text-subsection-onboarding',
            'type' => 'text',
            'label' => 'Slide 2 Icon (e.g. ti ti-truck-delivery)',
            'attributes' => [
                'name' => 'intro_icon_2',
                'value' => 'ti ti-truck-delivery',
                'options' => [
                    'class' => 'form-control',
                ],
            ],
        ])
        
        // Slide 3
        ->setField([
            'id' => 'intro_title_3',
            'section_id' => 'opt-text-subsection-onboarding',
            'type' => 'text',
            'label' => 'Slide 3 Title',
            'attributes' => [
                'name' => 'intro_title_3',
                'value' => 'دفع آمن',
                'options' => [
                    'class' => 'form-control',
                ],
            ],
        ])
        ->setField([
            'id' => 'intro_desc_3',
            'section_id' => 'opt-text-subsection-onboarding',
            'type' => 'textarea',
            'label' => 'Slide 3 Description',
            'attributes' => [
                'name' => 'intro_desc_3',
                'value' => 'طرق دفع متعددة وآمنة لتضمن راحة بالك أثناء التسوق.',
                'options' => [
                    'class' => 'form-control',
                    'rows' => 3,
                ],
            ],
        ])
        ->setField([
            'id' => 'intro_icon_3',
            'section_id' => 'opt-text-subsection-onboarding',
            'type' => 'text',
            'label' => 'Slide 3 Icon (e.g. ti ti-shield-check)',
            'attributes' => [
                'name' => 'intro_icon_3',
                'value' => 'ti ti-shield-check',
                'options' => [
                    'class' => 'form-control',
                ],
            ],
        ])
        
        // BNPL Integrations
        ->setSection([
            'title' => 'BNPL Integrations',
            'desc' => 'Buy Now, Pay Later settings (Taly, Deema, etc.)',
            'id' => 'opt-text-subsection-bnpl',
            'subsection' => true,
            'icon' => 'ti ti-credit-card',
        ])
        ->setField([
            'id' => 'deema_public_key',
            'section_id' => 'opt-text-subsection-bnpl',
            'type' => 'text',
            'label' => 'Deema Public Key',
            'attributes' => [
                'name' => 'deema_public_key',
                'value' => '',
                'options' => [
                    'class' => 'form-control',
                    'placeholder' => 'Enter your Deema Public Key here',
                ],
            ],
        ])
        
        // Logo
        ->setSection([
            'title' => 'Logo',
            'desc' => 'Theme logo settings',
            'id' => 'opt-text-subsection-logo',
            'subsection' => true,
            'icon' => 'ti ti-image',
        ])
        ->setField([
            'id' => 'topbar_logo',
            'section_id' => 'opt-text-subsection-logo',
            'type' => 'mediaImage',
            'label' => 'Topbar Logo',
            'attributes' => [
                'name' => 'topbar_logo',
                'value' => '',
            ],
        ])
        
        // Home Banners
        ->setSection([
            'title' => 'Homepage: Banners',
            'desc' => 'Two banners for the "Banners" homepage section (Homepage: Sections). Internal links like /products open inside the app.',
            'id' => 'opt-text-subsection-home-banners',
            'subsection' => true,
            'icon' => 'ti ti-layout-board',
        ])
        ->setField([
            'id' => 'home_banner_1_image',
            'section_id' => 'opt-text-subsection-home-banners',
            'type' => 'mediaImage',
            'label' => 'Banner 1 Image',
            'attributes' => [
                'name' => 'home_banner_1_image',
                'value' => '',
            ],
        ])
        ->setField([
            'id' => 'home_banner_1_link',
            'section_id' => 'opt-text-subsection-home-banners',
            'type' => 'text',
            'label' => 'Banner 1 Link',
            'attributes' => [
                'name' => 'home_banner_1_link',
                'value' => '',
                'options' => [
                    'class' => 'form-control',
                    'placeholder' => '/products',
                ],
            ],
        ])
        ->setField([
            'id' => 'home_banner_2_image',
            'section_id' => 'opt-text-subsection-home-banners',
            'type' => 'mediaImage',
            'label' => 'Banner 2 Image',
            'attributes' => [
                'name' => 'home_banner_2_image',
                'value' => '',
            ],
        ])
        ->setField([
            'id' => 'home_banner_2_link',
            'section_id' => 'opt-text-subsection-home-banners',
            'type' => 'text',
            'label' => 'Banner 2 Link',
            'attributes' => [
                'name' => 'home_banner_2_link',
                'value' => '',
                'options' => [
                    'class' => 'form-control',
                    'placeholder' => '/products',
                ],
            ],
        ]);
});

/**
 * Homepage builder + store contact/footer options.
 * Registered on the theme-options rendering event (Botble convention) so the category and
 * collection lists are only queried when the admin opens or saves the options page.
 */
app('events')->listen(\Botble\Theme\Events\RenderingThemeOptionSettings::class, function (): void {
    $yesNo = ['yes' => 'Yes', 'no' => 'No'];
    $text = fn (string $name, string $label, string $placeholder = '', ?string $helper = null) => [
        'type' => 'text',
        'label' => $label,
        'attributes' => ['name' => $name, 'value' => null, 'options' => ['class' => 'form-control', 'placeholder' => $placeholder]],
    ] + ($helper ? ['helper' => $helper] : []);
    $number = fn (string $name, string $label, int $default) => [
        'type' => 'number',
        'label' => $label,
        'attributes' => ['name' => $name, 'value' => $default, 'options' => ['class' => 'form-control', 'min' => 0]],
    ];
    $select = fn (string $name, string $label, array $list, ?string $helper = null) => [
        'type' => 'customSelect',
        'label' => $label,
        'attributes' => ['name' => $name, 'list' => $list, 'value' => array_key_first($list), 'options' => ['class' => 'form-control']],
    ] + ($helper ? ['helper' => $helper] : []);

    $categories = ['0' => '— select category —'];
    if (is_plugin_active('ecommerce')) {
        foreach (\Botble\Ecommerce\Models\ProductCategory::query()->wherePublished()->orderBy('parent_id')->orderBy('order')->get(['id', 'name', 'parent_id']) as $category) {
            $categories[(string) $category->id] = ($category->parent_id ? '— ' : '') . $category->name;
        }
    }
    $collections = ['0' => '— select collection —'];
    if (is_plugin_active('ecommerce')) {
        foreach (\Botble\Ecommerce\Models\ProductCollection::query()->wherePublished()->orderBy('name')->get(['id', 'name']) as $collection) {
            $collections[(string) $collection->id] = $collection->name;
        }
    }

    theme_option()
        ->setSection([
            'title' => 'Homepage: Sections',
            'desc' => 'Build the homepage from ordered sections. Each row is one section; "Order" decides the position (1 = top). Sections with no data are hidden automatically. Leave the list empty to use the default layout. Switch the admin language to translate titles.',
            'id' => 'opt-text-subsection-homepage-sections',
            'subsection' => true,
            'icon' => 'ti ti-layout-list',
            'priority' => 1,
            'fields' => [
                [
                    'id' => 'homepage_sections',
                    'type' => 'repeater',
                    'label' => 'Sections',
                    'attributes' => [
                        'name' => 'homepage_sections',
                        'value' => null,
                        'fields' => [
                            $select('type', 'Section type', [
                                'products' => 'Products',
                                'slider' => 'Slider (home-slider) / Hero',
                                'features' => 'Features bar (trust badges)',
                                'categories' => 'Featured categories',
                                'banners' => 'Banners',
                                'flash_sale' => 'Flash sale',
                                'wizard_cta' => 'System wizard call-to-action',
                            ]),
                            $select('enabled', 'Enabled', ['1' => 'Yes', '0' => 'No']),
                            $number('order', 'Order (1 = top)', 1),
                            $text('title', 'Title (optional)', 'Leave empty for the default title'),
                            $text('subtitle', 'Subtitle (optional)'),
                            $select('source', 'Products source (Products type only)', [
                                'featured' => 'Featured products',
                                'latest' => 'Latest products',
                                'best_selling' => 'Best selling (from orders)',
                                'category' => 'Products of a category',
                                'collection' => 'Products of a collection',
                            ]),
                            $select('category_id', 'Category (source = category)', $categories),
                            $select('collection_id', 'Collection (source = collection)', $collections),
                            $number('limit', 'Items limit', 8),
                            $select('layout', 'Layout (Products type)', ['grid' => 'Grid', 'scroll' => 'Horizontal scroll']),
                        ],
                    ],
                ],
            ],
        ])
        ->setSection([
            'title' => 'Homepage: Hero fallback',
            'desc' => 'Shown only when the "home-slider" has no published items. Add a slider (Simple Sliders → key: home-slider) to replace it.',
            'id' => 'opt-text-subsection-homepage-hero',
            'subsection' => true,
            'icon' => 'ti ti-photo',
            'priority' => 2,
            'fields' => [
                ['id' => 'hero_fallback_enabled'] + $select('hero_fallback_enabled', 'Show hero fallback', $yesNo),
                ['id' => 'hero_tag'] + $text('hero_tag', 'Small tag line', 'Weekly offers'),
                ['id' => 'hero_title'] + $text('hero_title', 'Title', 'The latest tech at the best prices'),
                ['id' => 'hero_description'] + $text('hero_description', 'Description'),
                ['id' => 'hero_button_text'] + $text('hero_button_text', 'Button text', 'Shop now'),
                ['id' => 'hero_button_url'] + $text('hero_button_url', 'Button link', '/products'),
            ],
        ])
        ->setSection([
            'title' => 'Homepage: Features bar',
            'desc' => 'Trust badges (warranty, delivery, support…). Icons: Tabler icon class, e.g. ti ti-truck-delivery.',
            'id' => 'opt-text-subsection-homepage-features',
            'subsection' => true,
            'icon' => 'ti ti-badges',
            'priority' => 3,
            'fields' => [
                [
                    'id' => 'home_features',
                    'type' => 'repeater',
                    'label' => 'Features',
                    'attributes' => [
                        'name' => 'home_features',
                        'value' => null,
                        'fields' => [
                            $select('enabled', 'Enabled', ['1' => 'Yes', '0' => 'No']),
                            $number('order', 'Order', 1),
                            $text('icon', 'Icon class', 'ti ti-truck-delivery'),
                            $text('title', 'Title', 'Free shipping'),
                            $text('description', 'Description', 'On orders over 20 KWD'),
                        ],
                    ],
                ],
            ],
        ])
        ->setSection([
            'title' => 'Homepage: Wizard CTA',
            'desc' => 'The "Find the right system" card linking to the project wizard.',
            'id' => 'opt-text-subsection-homepage-wizard',
            'subsection' => true,
            'icon' => 'ti ti-device-cctv',
            'priority' => 4,
            'fields' => [
                ['id' => 'wizard_cta_enabled'] + $select('wizard_cta_enabled', 'Show wizard card', $yesNo),
                ['id' => 'wizard_cta_title'] + $text('wizard_cta_title', 'Title', 'Leave empty for the default text'),
                ['id' => 'wizard_cta_subtitle'] + $text('wizard_cta_subtitle', 'Subtitle', 'Leave empty for the default text'),
            ],
        ])
        ->setSection([
            'title' => 'Store contact',
            'desc' => 'Shown in the top bar and footer.',
            'id' => 'opt-text-subsection-store-contact',
            'subsection' => true,
            'icon' => 'ti ti-phone',
            'fields' => [
                ['id' => 'hotline'] + $text('hotline', 'Hotline / phone', '+965 ...'),
                ['id' => 'email'] + $text('email', 'Email', 'info@example.com'),
                ['id' => 'address'] + $text('address', 'Address', 'Kuwait City'),
            ],
        ])
        ->setSection([
            'title' => 'Footer',
            'desc' => 'Footer links come from Appearance → Menus (location: Footer menu). Social links and Copyright have their own sections.',
            'id' => 'opt-text-subsection-footer',
            'subsection' => true,
            'icon' => 'ti ti-layout-bottombar',
            'fields' => [
                [
                    'id' => 'footer_about',
                    'type' => 'textarea',
                    'label' => 'About the store (short text)',
                    'attributes' => ['name' => 'footer_about', 'value' => null, 'options' => ['class' => 'form-control', 'rows' => 3]],
                ],
                [
                    'id' => 'payment_methods',
                    'type' => 'mediaImages',
                    'label' => 'Accepted payment methods (logos)',
                    'attributes' => ['name' => 'payment_methods[]', 'values' => theme_option('payment_methods', []), 'attributes' => ['allow_thumb' => false]],
                ],
                ['id' => 'payment_methods_link'] + $text('payment_methods_link', 'Payment methods link (optional)', 'https://...'),
            ],
        ]);
});
