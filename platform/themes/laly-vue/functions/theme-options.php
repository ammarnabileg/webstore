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
            'title' => 'Home Banners',
            'desc' => 'Two banners displayed under categories on the homepage.',
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
