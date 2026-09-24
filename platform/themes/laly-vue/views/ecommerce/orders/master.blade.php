<!DOCTYPE html>
<html {!! Theme::htmlAttributes() !!}>
<head>
    <meta charset="UTF-8">
    <meta
        name="viewport"
        content="width=device-width, initial-scale=1"
    >
    <meta
        name="csrf-token"
        content="{{ csrf_token() }}"
    >
    @php
        $description = trim((string) View::yieldContent('description')) ?: theme_option('ecommerce_checkout_seo_description');
    @endphp
    @if($description)
        <meta
            name="description"
            content="{{ $description }}"
        >
    @endif
    <title> @yield('title', __('Checkout')) </title>

    @if ($favicon = Theme::getFavicon())
        <link
            href="{{ RvMedia::getImageUrl($favicon) }}"
            rel="shortcut icon"
        >
    @endif

    {!! Theme::typography()->renderCssVariables() !!}

    <style>
        :root {
            --primary-color: {{ $primaryColor = theme_option('primary_color', '#58b3f0') }};
            --primary-color-rgb: {{ implode(',', BaseHelper::hexToRgb($primaryColor)) }};
            --checkout-primary-color: {{ $checkoutPrimaryColor = theme_option('checkout_primary_color', '#197bbd') }};
            --checkout-primary-color-rgb: {{ implode(',', BaseHelper::hexToRgb($checkoutPrimaryColor)) }};
        }
    </style>

    {!! Html::style('vendor/core/core/base/libraries/font-awesome/css/fontawesome.min.css?v=' . ($assetsVersion = EcommerceHelper::getAssetVersion())) !!}
    {!! Html::style('vendor/core/core/base/libraries/ckeditor/content-styles.css?v=' . $assetsVersion) !!}
    @if (BaseHelper::isRtlEnabled())
        {!! Html::style('vendor/core/plugins/ecommerce/libraries/bootstrap/bootstrap.rtl.min.css?v=' . $assetsVersion) !!}
    @else
        {!! Html::style('vendor/core/plugins/ecommerce/libraries/bootstrap/bootstrap.min.css?v=' . $assetsVersion) !!}
    @endif

    {!! Html::style('vendor/core/plugins/ecommerce/css/front-theme.css?v=' . $assetsVersion) !!}

    @if (BaseHelper::isRtlEnabled())
        {!! Html::style('vendor/core/plugins/ecommerce/css/front-theme-rtl.css?v=' . $assetsVersion) !!}
    @endif
    
    {!! Html::style(Theme::asset()->url('css/checkout.css') . '?v=' . (@filemtime(platform_path('themes/laly-vue/public/css/checkout.css')) ?: '1')) !!}

    {!! Html::style('vendor/core/core/base/libraries/toastr/toastr.min.css?v=' . $assetsVersion) !!}

    {!! Html::script('vendor/core/plugins/ecommerce/js/checkout.js?v=' . $assetsVersion) !!}

    @if (EcommerceHelper::loadCountriesStatesCitiesFromPluginLocation())
        <link
            href="{{ asset('vendor/core/core/base/libraries/select2/css/select2.min.css?v=' . $assetsVersion) }}"
            rel="stylesheet"
        >
        <script src="{{ asset('vendor/core/core/base/libraries/select2/js/select2.min.js?v=' . $assetsVersion) }}"></script>
        <script src="{{ asset('vendor/core/plugins/location/js/location.js?v=' . $assetsVersion) }}"></script>
    @endif

    {!! apply_filters('ecommerce_checkout_header', null) !!}

    @stack('header')
    
    <script>
        (function() {
            if (localStorage.getItem('theme') === 'dark') {
                document.documentElement.setAttribute('data-theme', 'dark');
            }
        })();
    </script>
</head>

@php
    Theme::addBodyAttributes([
        'class' => 'checkout-page',
    ]);
@endphp

<body{!! Theme::bodyAttributes() !!}>
    {!! apply_filters('ecommerce_checkout_body', null) !!}
    
    <!-- Top Action Bar for Language & Dark Mode -->
    <div class="checkout-top-bar d-flex justify-content-end align-items-center p-3">
        @if (is_plugin_active('language'))
            <div class="dropdown me-3 ms-3">
                <button class="btn btn-sm btn-outline-secondary dropdown-toggle d-flex align-items-center gap-2" type="button" id="languageDropdown" data-bs-toggle="dropdown" aria-expanded="false" style="border-radius: 20px; font-weight: 600;">
                    <i class="ti ti-world"></i> 
                    {{ Language::getCurrentLocaleName() }}
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow-sm" aria-labelledby="languageDropdown" style="border-radius: 12px; border: 1px solid var(--laly-surface-border);">
                    @foreach (Language::getSupportedLocales() as $localeCode => $properties)
                        <li>
                            <a class="dropdown-item @if($localeCode == Language::getCurrentLocale()) active @endif" href="{{ Language::getSwitcherUrl($localeCode, $properties['lang_code']) }}">
                                {{ $properties['lang_name'] }}
                            </a>
                        </li>
                    @endforeach
                </ul>
            </div>
        @endif
        
        <button id="theme-toggle" class="btn btn-sm btn-icon" style="border-radius: 50%; width: 36px; height: 36px; background: var(--laly-glass-bg); border: 1px solid var(--laly-surface-border); display: flex; align-items: center; justify-content: center; color: var(--laly-text);">
            <i class="ti ti-moon" id="theme-icon"></i>
        </button>
    </div>

    <div class="container my-0 my-md-3 my-lg-5 checkout-content-wrap">
        @yield('content')
    </div>

    @stack('footer')

    {!! Html::script('vendor/core/plugins/ecommerce/js/utilities.js?v=' . $assetsVersion) !!}
    {!! Html::script('vendor/core/core/base/libraries/toastr/toastr.min.js?v=' . $assetsVersion) !!}

    <script type="text/javascript">
        window.messages = {
            error_header: '{{ __('Error') }}',
            success_header: '{{ __('Success') }}',
        }
    </script>

    @if (session()->has('success_msg') || session()->has('error_msg') || isset($errors))
        <script type="text/javascript">
            $(document).ready(function() {
                @if (session()->has('success_msg') && session('success_msg'))
                    MainCheckout.showNotice('success', '{{ session('success_msg') }}');
                @endif
                @if (session()->has('error_msg'))
                    MainCheckout.showNotice('error', '{{ session('error_msg') }}');
                @endif
                @if (isset($errors) && $errors->count())
                    MainCheckout.showNotice('error', '{{ $errors->first() }}');
                @endif
            });
        </script>
    @endif

    {!! apply_filters('ecommerce_checkout_footer', null) !!}

    <script>
        // Initialize floating labels for checkout forms
        document.addEventListener('DOMContentLoaded', function() {
            // Add placeholder=" " to all inputs in form-input-wrapper to enable :placeholder-shown
            document.querySelectorAll('.form-input-wrapper input.form-control').forEach(function(input) {
                if (!input.hasAttribute('placeholder')) {
                    input.setAttribute('placeholder', ' ');
                }
                
                // Check if input has value on load (for autofilled or pre-filled fields)
                if (input.value && input.value.trim() !== '') {
                    input.classList.add('has-value');
                }
                
                // Add/remove class on input change
                input.addEventListener('input', function() {
                    if (this.value && this.value.trim() !== '') {
                        this.classList.add('has-value');
                    } else {
                        this.classList.remove('has-value');
                    }
                });
                
                // Handle autofill
                input.addEventListener('change', function() {
                    if (this.value && this.value.trim() !== '') {
                        this.classList.add('has-value');
                    } else {
                        this.classList.remove('has-value');
                    }
                });
            });
            
            // Handle select elements - they should always have floating labels
            document.querySelectorAll('.form-input-wrapper select.form-control').forEach(function(select) {
                select.classList.add('has-value');
            });
        });
    </script>
    <script>
        // Dark Mode Toggle Logic
        document.addEventListener('DOMContentLoaded', function() {
            const themeToggleBtn = document.getElementById('theme-toggle');
            const themeIcon = document.getElementById('theme-icon');
            
            function updateIcon() {
                if (document.documentElement.getAttribute('data-theme') === 'dark') {
                    themeIcon.classList.remove('ti-moon');
                    themeIcon.classList.add('ti-sun');
                } else {
                    themeIcon.classList.remove('ti-sun');
                    themeIcon.classList.add('ti-moon');
                }
            }
            
            updateIcon();

            themeToggleBtn.addEventListener('click', function() {
                let currentTheme = document.documentElement.getAttribute('data-theme');
                if (currentTheme === 'dark') {
                    document.documentElement.removeAttribute('data-theme');
                    localStorage.setItem('theme', 'light');
                } else {
                    document.documentElement.setAttribute('data-theme', 'dark');
                    localStorage.setItem('theme', 'dark');
                }
                updateIcon();
            });
            
            // Fix Bootstrap Dropdown inside checkout
            if (typeof bootstrap === 'undefined') {
                const script = document.createElement('script');
                script.src = 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js';
                document.body.appendChild(script);
            }
        });
    </script>
</body>
</html>
