@php
    // Locale prefix so links match production (default locale unprefixed, others under /<code>).
    $lp = '';
    if (is_plugin_active('language')) {
        $cur = \Botble\Language\Facades\Language::getCurrentLocaleCode();
        $def = \Botble\Language\Facades\Language::getDefaultLocaleCode();
        if ($cur && $cur !== $def) {
            $lp = '/' . $cur;
        }
    }
    $home = $lp ?: '/';
    $logoOption = theme_option('topbar_logo') ?: theme_option('logo');
    $logo = $logoOption ? RvMedia::getImageUrl($logoOption) : null;
    // Only use a configured store title; never fall back to the framework's default APP_NAME.
    $siteTitle = theme_option('site_title') ?: __('home');
@endphp
<header class="blade-chrome blade-chrome-header">
    <a href="javascript:history.length>1?history.back():location.assign('{{ $home }}')" class="bc-btn" aria-label="{{ __('back') }}"><i class="ti ti-arrow-right"></i></a>
    <a href="{{ $home }}" class="bc-logo" aria-label="{{ $siteTitle }}">
        @if($logo)<img src="{{ $logo }}" alt="{{ $siteTitle }}">@else<i class="ti ti-home" style="font-size:24px;color:var(--primary,#2193b0)"></i>@endif
    </a>
    <span class="bc-actions">
        <a href="{{ $lp }}/cart" class="bc-btn" aria-label="{{ __('cart') }}"><i class="ti ti-shopping-cart"></i></a>
        <a href="{{ $lp }}/profile" class="bc-btn" aria-label="{{ __('account') }}"><i class="ti ti-user"></i></a>
    </span>
</header>
<nav class="blade-chrome blade-chrome-tabbar tabbar" aria-label="{{ $siteTitle }}">
    <a href="{{ $home }}"><i class="ti ti-home"></i><span>{{ __('home') }}</span></a>
    <a href="{{ $lp }}/products"><i class="ti ti-layout-grid"></i><span>{{ __('products') }}</span></a>
    <a href="{{ $lp }}/cart"><i class="ti ti-shopping-cart"></i><span>{{ __('cart') }}</span></a>
    <a href="{{ $lp }}/profile"><i class="ti ti-user"></i><span>{{ __('account') }}</span></a>
</nav>
<style>
    .blade-chrome-header{position:sticky;top:0;z-index:50;display:flex;align-items:center;justify-content:space-between;
        gap:12px;padding:10px 16px;background:var(--surface,#fff);border-bottom:1px solid var(--line,#dbe6ea)}
    .blade-chrome-header .bc-logo img{height:32px;width:auto;object-fit:contain}
    .blade-chrome-header .bc-logo span{font-weight:700;color:var(--ink,#10232b)}
    .blade-chrome .bc-btn{display:inline-flex;align-items:center;justify-content:center;width:40px;height:40px;
        border-radius:12px;color:var(--ink,#10232b);background:var(--surface-2,#eef4f6);text-decoration:none;font-size:20px}
    .blade-chrome-header .bc-actions{display:flex;gap:8px}
    body{padding-bottom:72px}
    .blade-chrome-tabbar{position:fixed;bottom:0;left:0;right:0;z-index:50;display:flex;justify-content:space-around;
        padding:8px 4px;background:var(--surface,#fff);border-top:1px solid var(--line,#dbe6ea)}
    .blade-chrome-tabbar a{display:flex;flex-direction:column;align-items:center;gap:2px;flex:1;
        color:var(--ink-2,#4a6570);text-decoration:none;font-size:11px}
    .blade-chrome-tabbar a i{font-size:22px}
    @media (min-width:992px){ .blade-chrome-tabbar{display:none} body{padding-bottom:0} }
</style>
