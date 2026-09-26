<!DOCTYPE html>
@php
    $isRTL = BaseHelper::siteLanguageDirection() == 'rtl';
    $languages = [];
    if (is_plugin_active('language')) {
        foreach (Language::getSupportedLocales() as $localeCode => $properties) {
            $languages[] = [
                'code' => $localeCode,
                'name' => $properties['lang_name'],
                'url' => Language::getSwitcherUrl($localeCode, $properties['lang_code']),
                'active' => $localeCode == Language::getCurrentLocale(),
            ];
        }
    }
    
    $homeSliders = [];
    if (is_plugin_active('simple-slider')) {
        $slider = \Botble\SimpleSlider\Models\SimpleSlider::with(['sliderItems' => function($q) {
            $q->where('status', 'published')->orderBy('order', 'ASC');
        }])->where('key', 'home-slider')->first();
        
        if (!$slider) {
            $slider = \Botble\SimpleSlider\Models\SimpleSlider::with(['sliderItems' => function($q) {
                $q->where('status', 'published')->orderBy('order', 'ASC');
            }])->where('status', 'published')->first();
        }

        if ($slider && $slider->sliderItems) {
            foreach ($slider->sliderItems as $item) {
                $img = RvMedia::getImageUrl($item->image);
                $mobileImg = $item->getMetaData('mobile_image', true);
                $mobileImg = $mobileImg ? RvMedia::getImageUrl($mobileImg) : $img;

                $homeSliders[] = [
                    'id' => $item->id,
                    'title' => $item->title,
                    'description' => $item->description,
                    'link' => $item->link,
                    'image' => $img,
                    'mobile_image' => $mobileImg,
                ];
            }
        }
    }

    $customer = auth('customer')->user();
    $customerData = $customer ? [
        'id' => $customer->id,
        'name' => $customer->name,
        'email' => $customer->email,
        'phone' => $customer->phone,
        'avatar' => $customer->avatar_url ?? RvMedia::getImageUrl($customer->avatar, 'thumb', false, RvMedia::getDefaultImage()),
    ] : null;
@endphp
<html lang="{{ app()->getLocale() }}" dir="{{ $isRTL ? 'rtl' : 'ltr' }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    @if (!empty($languages))
        @foreach ($languages as $language)
            <link rel="alternate" hreflang="{{ $language['code'] }}" href="{{ $language['url'] }}" />
        @endforeach
        @php
            $defaultLocale = is_plugin_active('language') ? Language::getDefaultLocale() : app()->getLocale();
            $defaultLang = collect($languages)->firstWhere('code', $defaultLocale);
            $defaultUrl = $defaultLang ? $defaultLang['url'] : url('/');
        @endphp
        <link rel="alternate" hreflang="x-default" href="{{ $defaultUrl }}" />
    @endif
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@400;500;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@3.48.0/dist/tabler-icons.min.css">
    <script>
        @php
            $socialLogins = [];
            if (is_plugin_active('social-login') && class_exists('\Botble\SocialLogin\Facades\SocialService')) {
                foreach (\Botble\SocialLogin\Facades\SocialService::getProviderKeys() as $key) {
                    if (\Botble\SocialLogin\Facades\SocialService::getProviderEnabled($key)) {
                        $socialLogins[] = [
                            'provider' => $key,
                            'name' => trans('plugins/social-login::social-login.socials.' . $key),
                            'url' => route('auth.social', $key)
                        ];
                    }
                }
            }
        @endphp
        window.BotbleData = {
            logo: @json(RvMedia::getImageUrl(theme_option('logo'))),
            topbarLogo: @json(theme_option('topbar_logo') ? RvMedia::getImageUrl(theme_option('topbar_logo')) : RvMedia::getImageUrl(theme_option('logo'))),
            placeholderImage: @json(theme_option('lazyload_image') ? RvMedia::getImageUrl(theme_option('lazyload_image')) : RvMedia::getDefaultImage()),
            site_title: @json(theme_option('site_title')),
            locale: @json(app()->getLocale()),
            is_rtl: @json($isRTL),
            baseUrl: @json(url('')),
            languages: @json($languages),
            homeSliders: @json($homeSliders),
            hotline: @json(theme_option('hotline')),
            address: @json(theme_option('address')),
            email: @json(theme_option('email')),
            customer: @json($customerData),
            loginUrl: @json(route('customer.login')),
            logoutUrl: @json(route('customer.logout')),
            firebase_config: @json(function_exists('laly_notifications_web_config') && is_plugin_active('laly-notifications') ? laly_notifications_web_config() : null),
            ordersUrl: @json(route('customer.orders')),
            accountUrl: @json(route('customer.edit-account')),
            checkoutUrl: @json(route('public.checkout.information', \Botble\Ecommerce\Facades\OrderHelper::getOrderSessionToken())),
            isPhoneLoginEnabled: @json(\Botble\Ecommerce\Facades\EcommerceHelper::isLoginUsingPhone()),
            isPhoneRequired: @json(\Botble\Ecommerce\Facades\EcommerceHelper::isLoginUsingPhone() || get_ecommerce_setting('make_customer_phone_number_required', false)),
            onboarding: {
                slide1: {
                    title: @json(theme_option('intro_title_1', 'تسوق بسهولة')),
                    desc: @json(theme_option('intro_desc_1', 'اكتشف آلاف المنتجات بأسعار تنافسية وتجربة تسوق لا مثيل لها.')),
                    icon: @json(theme_option('intro_icon_1', 'ti ti-shopping-cart'))
                },
                slide2: {
                    title: @json(theme_option('intro_title_2', 'توصيل سريع')),
                    desc: @json(theme_option('intro_desc_2', 'نوفر لك خيارات توصيل سريعة وموثوقة لجميع أنحاء البلاد.')),
                    icon: @json(theme_option('intro_icon_2', 'ti ti-truck-delivery'))
                },
                slide3: {
                    title: @json(theme_option('intro_title_3', 'دفع آمن')),
                    desc: @json(theme_option('intro_desc_3', 'طرق دفع متعددة وآمنة لتضمن راحة بالك أثناء التسوق.')),
                    icon: @json(theme_option('intro_icon_3', 'ti ti-shield-check'))
                }
            },
            homeBanners: [
                {
                    image: @json(theme_option('home_banner_1_image') ? RvMedia::getImageUrl(theme_option('home_banner_1_image')) : ''),
                    link: @json(theme_option('home_banner_1_link', ''))
                },
                {
                    image: @json(theme_option('home_banner_2_image') ? RvMedia::getImageUrl(theme_option('home_banner_2_image')) : ''),
                    link: @json(theme_option('home_banner_2_link', ''))
                }
            ],
            socialLogins: @json($socialLogins)
        };
        (function() {
            if (localStorage.getItem('theme') === 'dark') {
                document.documentElement.setAttribute('data-theme', 'dark');
            }
        })();
        
        var deemaWidgetConfiguration = {
            publicKey: @json(theme_option('deema_public_key', ''))
        };
    </script>
    <script src="https://widget.deema.me" defer></script>
    {!! Theme::header() !!}
</head>
<body>
    @php
        $themeContent = Theme::content();
        // SPA views mount into <div id="app">. Everything else is an inherited martfury/Blade page;
        // wrap those with lightweight chrome so the user is not stranded without navigation.
        $isSpaView = str_contains($themeContent, 'id="app"');
    @endphp
    @if ($isSpaView)
        {!! $themeContent !!}
    @else
        @include(Theme::getThemeNamespace() . '::partials.blade-chrome')
        <main class="blade-fallback-content">{!! $themeContent !!}</main>
    @endif
    {!! Theme::footer() !!}
</body>
</html>
