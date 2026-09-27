<?php

/**
 * Dynamic homepage sections for the laly-vue storefront.
 *
 * The admin describes the homepage as an ordered list of sections in Theme options
 * (repeater "homepage_sections"). This file turns that config into a resolved payload
 * (`laly_vue_homepage_sections()`) served by `GET ajax/vue/home-sections` and rendered by
 * `components/home/HomeSections.vue`. Sections with no data are dropped here so the
 * storefront never shows an empty title or grid.
 *
 * Extending: add a type to LALY_VUE_HOME_TYPES + a `laly_vue_home_resolve_<type>()` function,
 * or a product source to LALY_VUE_HOME_SOURCES + a case in `laly_vue_home_products_for()`.
 */

use Botble\Base\Facades\BaseHelper;
use Botble\Ecommerce\Enums\OrderStatusEnum;
use Botble\Ecommerce\Models\FlashSale;
use Botble\Ecommerce\Models\Product;
use Botble\Ecommerce\Models\ProductCategory;
use Botble\Ecommerce\Models\ProductCollection;
use Botble\Media\Facades\RvMedia;
use Botble\Menu\Models\Menu as MenuModel;
use Botble\Theme\Supports\ThemeSupport;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

const LALY_VUE_HOME_TYPES = ['slider', 'features', 'wizard_cta', 'categories', 'banners', 'flash_sale', 'products', 'stats', 'brands'];
const LALY_VUE_HOME_SOURCES = ['featured', 'latest', 'best_selling', 'category', 'collection'];
const LALY_VUE_HOME_LAYOUTS = ['grid', 'scroll'];
const LALY_VUE_HOME_CACHE_TTL = 300;

if (! function_exists('laly_vue_repeater_rows')) {
    /**
     * Botble stores repeater values as [[{key,value}, ...], ...]; flatten each row to key => value.
     */
    function laly_vue_repeater_rows(mixed $raw): array
    {
        $data = is_string($raw) ? json_decode($raw, true) : $raw;
        if (! is_array($data)) {
            return [];
        }

        $rows = [];
        foreach ($data as $row) {
            if (! is_array($row)) {
                continue;
            }
            $flat = [];
            foreach ($row as $field) {
                if (is_array($field) && isset($field['key'])) {
                    $flat[$field['key']] = $field['value'] ?? null;
                }
            }
            if ($flat) {
                $rows[] = $flat;
            }
        }

        return $rows;
    }
}

if (! function_exists('laly_vue_homepage_default_sections')) {
    /**
     * Used until the admin saves "Homepage sections": reproduces the layout the store shipped with
     * (minus the duplicated "latest products" block), so upgrading changes nothing visually.
     */
    function laly_vue_homepage_default_sections(): array
    {
        return [
            ['type' => 'slider', 'order' => 1],
            ['type' => 'features', 'order' => 2],
            ['type' => 'categories', 'order' => 3, 'limit' => 12],
            ['type' => 'flash_sale', 'order' => 4, 'limit' => 4],
            ['type' => 'products', 'source' => 'best_selling', 'order' => 5, 'limit' => 8, 'layout' => 'scroll'],
            ['type' => 'banners', 'order' => 6],
            ['type' => 'stats', 'order' => 7],
            ['type' => 'wizard_cta', 'order' => 8],
            ['type' => 'products', 'source' => 'featured', 'order' => 9, 'limit' => 8],
            ['type' => 'products', 'source' => 'latest', 'order' => 10, 'limit' => 8, 'layout' => 'scroll'],
            ['type' => 'brands', 'order' => 11],
        ];
    }
}

if (! function_exists('laly_vue_homepage_default_sections_repeater')) {
    /**
     * The default sections in the repeater's stored format, so Theme options → Homepage: Sections
     * opens pre-filled with exactly what the storefront shows instead of an empty list
     * (adding one row to an empty list would otherwise silently replace all eleven defaults).
     */
    function laly_vue_homepage_default_sections_repeater(): string
    {
        $keys = ['type', 'enabled', 'order', 'title', 'subtitle', 'source', 'category_id', 'collection_id', 'limit', 'layout'];
        $rows = [];
        foreach (laly_vue_homepage_default_sections() as $section) {
            $section += ['enabled' => '1', 'source' => 'featured', 'limit' => 8, 'layout' => 'grid'];
            $rows[] = array_map(
                fn (string $key) => ['key' => $key, 'value' => isset($section[$key]) ? (string) $section[$key] : ''],
                $keys
            );
        }

        return json_encode($rows, JSON_UNESCAPED_UNICODE);
    }
}

if (! function_exists('laly_vue_homepage_sections_config')) {
    /**
     * Enabled sections from Theme options, normalised and sorted by "order".
     */
    function laly_vue_homepage_sections_config(): array
    {
        $rows = laly_vue_repeater_rows(theme_option('homepage_sections'));
        if (! $rows) {
            $rows = laly_vue_homepage_default_sections();
        }

        $sections = [];
        foreach ($rows as $index => $row) {
            $type = (string) Arr::get($row, 'type', '');
            if (! in_array($type, LALY_VUE_HOME_TYPES, true)) {
                continue;
            }
            $enabled = Arr::get($row, 'enabled', '1');
            if (in_array((string) $enabled, ['0', 'no', 'false', 'off'], true)) {
                continue;
            }
            $source = (string) Arr::get($row, 'source', 'featured');
            $sections[] = [
                'id' => $type . '-' . $index,
                'type' => $type,
                'order' => (int) Arr::get($row, 'order', $index + 1),
                'title' => trim((string) Arr::get($row, 'title', '')),
                'subtitle' => trim((string) Arr::get($row, 'subtitle', '')),
                'source' => in_array($source, LALY_VUE_HOME_SOURCES, true) ? $source : 'featured',
                'category_id' => (int) Arr::get($row, 'category_id', 0),
                'collection_id' => (int) Arr::get($row, 'collection_id', 0),
                'limit' => min(max((int) Arr::get($row, 'limit') ?: 8, 1), 24),
                'layout' => in_array(Arr::get($row, 'layout'), LALY_VUE_HOME_LAYOUTS, true) ? Arr::get($row, 'layout') : 'grid',
            ];
        }

        usort($sections, fn ($a, $b) => $a['order'] <=> $b['order']);

        return $sections;
    }
}

if (! function_exists('laly_vue_home_products_query')) {
    function laly_vue_home_products_query(): Builder
    {
        return Product::query()
            ->wherePublished()
            ->where('is_variation', false)
            ->with(['slugable', 'productLabels', 'metadata']);
    }
}

if (! function_exists('laly_vue_home_best_selling_ids')) {
    /**
     * Parent product ids ordered by quantity sold across finished, non-cancelled orders.
     * Variation sales are credited to their configurable (parent) product.
     */
    function laly_vue_home_best_selling_ids(int $limit): array
    {
        return DB::table('ec_order_product as op')
            ->join('ec_orders as o', 'o.id', '=', 'op.order_id')
            ->leftJoin('ec_product_variations as v', 'v.product_id', '=', 'op.product_id')
            ->where('o.is_finished', 1)
            ->whereNotIn('o.status', [OrderStatusEnum::CANCELED, OrderStatusEnum::RETURNED])
            ->groupBy('pid')
            ->orderByDesc('sold')
            ->limit($limit)
            ->select([DB::raw('COALESCE(v.configurable_product_id, op.product_id) as pid'), DB::raw('SUM(op.qty) as sold')])
            ->get()
            ->map(fn ($row) => (int) $row->pid)
            ->all();
    }
}

if (! function_exists('laly_vue_home_category_ids')) {
    function laly_vue_home_category_ids(int $categoryId): array
    {
        $category = ProductCategory::query()->wherePublished()->with('activeChildren')->find($categoryId);
        if (! $category) {
            return [];
        }

        return array_values(array_unique(ProductCategory::getChildrenIds($category->activeChildren, [$category->id])));
    }
}

if (! function_exists('laly_vue_home_products_for')) {
    /**
     * Product source registry. Returns [products, view_all_url].
     */
    function laly_vue_home_products_for(array $section): array
    {
        $limit = $section['limit'];
        $query = laly_vue_home_products_query();

        switch ($section['source']) {
            case 'featured':
                return [$query->where('is_featured', 1)->orderByDesc('created_at')->limit($limit)->get(), '/products'];

            case 'latest':
                return [$query->orderByDesc('created_at')->limit($limit)->get(), '/products?sort=newest'];

            case 'best_selling':
                $ids = laly_vue_home_best_selling_ids($limit);
                if (! $ids) {
                    return [collect(), '/products'];
                }
                $products = $query->whereIn('id', $ids)->get()->sortBy(fn ($p) => array_search($p->id, $ids))->values();

                return [$products, '/products'];

            case 'category':
                $ids = laly_vue_home_category_ids($section['category_id']);
                if (! $ids) {
                    return [collect(), '/products'];
                }
                $category = ProductCategory::query()->with('slugable')->find($section['category_id']);
                $products = $query
                    ->whereHas('categories', fn ($q) => $q->whereIn('ec_product_categories.id', $ids))
                    ->orderByDesc('created_at')->limit($limit)->get();

                return [$products, $category && $category->slug ? '/product-categories/' . $category->slug : '/products'];

            case 'collection':
                if (! $section['collection_id']) {
                    return [collect(), '/products'];
                }
                $products = $query
                    ->whereHas('productCollections', fn ($q) => $q->where('ec_product_collections.id', $section['collection_id']))
                    ->orderByDesc('created_at')->limit($limit)->get();

                return [$products, '/products?collections=' . $section['collection_id']];
        }

        return [collect(), '/products'];
    }
}

if (! function_exists('laly_vue_home_default_title')) {
    /**
     * Only category/collection sections get a server-side default title (the entity name);
     * the storefront translates the generic ones (featured/latest/best sellers/flash sale…) itself.
     */
    function laly_vue_home_default_title(array $section): string
    {
        if ($section['type'] !== 'products') {
            return '';
        }

        return match ($section['source']) {
            'category' => html_entity_decode((string) (ProductCategory::query()->find($section['category_id'])?->name ?? '')),
            'collection' => html_entity_decode((string) (ProductCollection::query()->find($section['collection_id'])?->name ?? '')),
            default => '',
        };
    }
}

if (! function_exists('laly_vue_is_internal_url')) {
    function laly_vue_is_internal_url(?string $url): bool
    {
        if (! $url) {
            return false;
        }
        if (Str::startsWith($url, ['/', '#'])) {
            return true;
        }
        $host = strtolower((string) parse_url($url, PHP_URL_HOST));
        if (! $host) {
            return false;
        }
        // Absolute links saved from the dashboard use APP_URL; the request host covers dev/staging mirrors.
        $own = array_filter([
            strtolower((string) parse_url((string) config('app.url'), PHP_URL_HOST)),
            strtolower((string) request()->getHost()),
        ]);

        return in_array($host, $own, true);
    }
}

if (! function_exists('laly_vue_relative_url')) {
    /** Strip scheme/host (and the language prefix) so the SPA router can handle the link. */
    function laly_vue_relative_url(string $url): string
    {
        $path = laly_vue_is_internal_url($url) && ! Str::startsWith($url, ['/', '#'])
            ? (parse_url($url, PHP_URL_PATH) ?: '/') . (parse_url($url, PHP_URL_QUERY) ? '?' . parse_url($url, PHP_URL_QUERY) : '')
            : $url;
        $path = preg_replace('#^/(ar|en)(/|$)#', '/', $path) ?: '/';

        return $path;
    }
}

if (! function_exists('laly_vue_home_slides')) {
    /**
     * Published items of the "home-slider" (or the first published slider as fallback).
     */
    function laly_vue_home_slides(): array
    {
        if (! is_plugin_active('simple-slider')) {
            return [];
        }

        $with = ['sliderItems' => fn ($q) => $q->wherePublished()->orderBy('order')->with('metadata')];
        $slider = \Botble\SimpleSlider\Models\SimpleSlider::query()->wherePublished()->with($with)->where('key', 'home-slider')->first()
            ?: \Botble\SimpleSlider\Models\SimpleSlider::query()->wherePublished()->with($with)->first();

        if (! $slider) {
            return [];
        }

        $slides = [];
        foreach ($slider->sliderItems as $item) {
            if (! $item->image) {
                continue;
            }
            $mobile = $item->getMetaData('mobile_image', true);
            $slides[] = [
                'id' => $item->id,
                'title' => (string) $item->title,
                'description' => (string) $item->description,
                'link' => (string) $item->link,
                'internal' => laly_vue_is_internal_url($item->link),
                'button_text' => (string) $item->getMetaData('button_text', true),
                'image' => RvMedia::getImageUrl($item->image),
                'mobile_image' => $mobile ? RvMedia::getImageUrl($mobile) : RvMedia::getImageUrl($item->image),
            ];
        }

        return $slides;
    }
}

if (! function_exists('laly_vue_home_banners')) {
    function laly_vue_home_banners(): array
    {
        $banners = [];
        foreach ([1, 2] as $i) {
            $image = theme_option('home_banner_' . $i . '_image');
            if (! $image) {
                continue;
            }
            $link = (string) theme_option('home_banner_' . $i . '_link', '');
            $banners[] = [
                'image' => RvMedia::getImageUrl($image),
                'link' => $link,
                'internal' => laly_vue_is_internal_url($link),
                // Optional copy: with a title the banner renders as a promo card (text + image),
                // without it the image stays a plain full-width banner.
                'title' => trim((string) theme_option('home_banner_' . $i . '_title', '')),
                'text' => trim((string) theme_option('home_banner_' . $i . '_text', '')),
                'button_text' => trim((string) theme_option('home_banner_' . $i . '_button', '')),
            ];
        }

        return $banners;
    }
}

if (! function_exists('laly_vue_home_features')) {
    function laly_vue_home_features(): array
    {
        $rows = laly_vue_repeater_rows(theme_option('home_features'));
        if (! $rows) {
            $rows = [
                ['icon' => 'ti ti-shield-check', 'title' => __('Full warranty'), 'description' => __('On all devices')],
                ['icon' => 'ti ti-truck-delivery', 'title' => __('Secure delivery'), 'description' => __('For sensitive equipment')],
                ['icon' => 'ti ti-headset', 'title' => __('Tech support'), 'description' => __('Technical experts')],
            ];
        }

        $items = [];
        foreach ($rows as $index => $row) {
            if (in_array((string) Arr::get($row, 'enabled', '1'), ['0', 'no'], true)) {
                continue;
            }
            $title = trim((string) Arr::get($row, 'title', ''));
            if ($title === '') {
                continue;
            }
            $items[] = [
                'order' => (int) Arr::get($row, 'order', $index + 1),
                'icon' => trim((string) Arr::get($row, 'icon', '')) ?: 'ti ti-circle-check',
                'title' => $title,
                'description' => trim((string) Arr::get($row, 'description', '')),
            ];
        }
        usort($items, fn ($a, $b) => $a['order'] <=> $b['order']);

        return $items;
    }
}

if (! function_exists('laly_vue_home_stat_rows')) {
    /**
     * Rows of a "value + label" repeater (hero_stats / home_stats), blank rows dropped.
     */
    function laly_vue_home_stat_rows(string $option): array
    {
        $items = [];
        foreach (laly_vue_repeater_rows(theme_option($option)) as $row) {
            $value = trim((string) Arr::get($row, 'value', ''));
            $label = trim((string) Arr::get($row, 'label', ''));
            if ($value === '' || $label === '') {
                continue;
            }
            $items[] = ['value' => $value, 'label' => $label];
        }

        return $items;
    }
}

// ---- Section resolvers: return the section with `data`, or null when there is nothing to show.

if (! function_exists('laly_vue_home_resolve_stats')) {
    function laly_vue_home_resolve_stats(array $section): ?array
    {
        $items = laly_vue_home_stat_rows('home_stats');

        return $items ? $section + ['data' => ['items' => $items]] : null;
    }
}

if (! function_exists('laly_vue_home_resolve_brands')) {
    function laly_vue_home_resolve_brands(array $section): ?array
    {
        $brands = \Botble\Ecommerce\Models\Brand::query()
            ->wherePublished()
            ->with('slugable')
            ->orderBy('order')
            ->limit(max($section['limit'], 12))
            ->get();

        if ($brands->count() < 2) {
            return null;
        }

        return $section + ['data' => ['items' => $brands->map(fn ($b) => [
            'id' => $b->id,
            'name' => html_entity_decode($b->name),
            'slug' => $b->slug,
            'logo' => $b->logo ? RvMedia::getImageUrl($b->logo) : null,
        ])->values()->all()]];
    }
}

if (! function_exists('laly_vue_home_resolve_slider')) {
    function laly_vue_home_resolve_slider(array $section): ?array
    {
        $slides = laly_vue_home_slides();
        if ($slides) {
            return $section + ['data' => [
                'slides' => $slides,
                'eyebrow' => trim((string) theme_option('hero_tag', '')),
                'stats' => laly_vue_home_stat_rows('hero_stats'),
            ]];
        }

        // Static hero fallback, only when no slider is configured and the admin left it enabled.
        if ((string) theme_option('hero_fallback_enabled', 'yes') === 'no') {
            return null;
        }
        // Empty texts fall back to the storefront's translated defaults (i18n hero_* keys).
        $url = (string) theme_option('hero_button_url', '') ?: '/products';

        return ['id' => $section['id'], 'type' => 'hero', 'order' => $section['order'], 'data' => [
            'tag' => (string) theme_option('hero_tag', ''),
            'title' => trim((string) theme_option('hero_title', '')),
            'description' => (string) theme_option('hero_description', ''),
            'button_text' => (string) theme_option('hero_button_text', ''),
            'button_url' => $url,
            'internal' => laly_vue_is_internal_url($url),
        ]];
    }
}

if (! function_exists('laly_vue_home_resolve_features')) {
    function laly_vue_home_resolve_features(array $section): ?array
    {
        $items = laly_vue_home_features();

        return $items ? $section + ['data' => ['items' => $items]] : null;
    }
}

if (! function_exists('laly_vue_home_resolve_wizard_cta')) {
    function laly_vue_home_resolve_wizard_cta(array $section): ?array
    {
        if (! is_plugin_active('system-wizard') || (string) theme_option('wizard_cta_enabled', 'yes') === 'no') {
            return null;
        }

        return $section + ['data' => [
            'title' => (string) theme_option('wizard_cta_title', ''),
            'subtitle' => (string) theme_option('wizard_cta_subtitle', ''),
        ]];
    }
}

if (! function_exists('laly_vue_home_resolve_categories')) {
    function laly_vue_home_resolve_categories(array $section): ?array
    {
        $categories = ProductCategory::query()
            ->wherePublished()
            ->where('is_featured', 1)
            ->where(fn ($q) => $q->whereNull('parent_id')->orWhere('parent_id', 0))
            ->with('slugable')
            ->orderBy('order')
            ->limit($section['limit'])
            ->get();

        if ($categories->isEmpty()) {
            return null;
        }

        return $section + ['data' => ['items' => $categories->map(fn ($c) => [
            'id' => $c->id,
            'name' => html_entity_decode($c->name),
            'slug' => $c->slug,
            'image' => $c->image ? RvMedia::getImageUrl($c->image, 'thumb') : null,
            'icon' => $c->icon,
        ])->values()->all()]];
    }
}

if (! function_exists('laly_vue_home_resolve_banners')) {
    function laly_vue_home_resolve_banners(array $section): ?array
    {
        $banners = laly_vue_home_banners();

        return $banners ? $section + ['data' => ['items' => $banners]] : null;
    }
}

if (! function_exists('laly_vue_home_resolve_flash_sale')) {
    function laly_vue_home_resolve_flash_sale(array $section): ?array
    {
        $flashSale = FlashSale::query()
            ->wherePublished()
            ->notExpired()
            ->with(['products' => fn ($q) => $q->wherePublished()->where('is_variation', false)->with(['slugable', 'productLabels', 'metadata'])])
            ->orderBy('end_date')
            ->get()
            ->first(fn ($fs) => $fs->products->isNotEmpty());

        if (! $flashSale) {
            return null;
        }

        return $section + ['data' => [
            'name' => (string) $flashSale->name,
            // The sale is valid through the whole end date; the client counts down to that moment.
            'ends_at' => $flashSale->end_date->copy()->endOfDay()->toIso8601String(),
            'products' => $flashSale->products->take($section['limit'])->map(fn ($p) => laly_vue_product_card($p))->values()->all(),
        ]];
    }
}

if (! function_exists('laly_vue_home_resolve_products')) {
    function laly_vue_home_resolve_products(array $section): ?array
    {
        [$products, $viewAll] = laly_vue_home_products_for($section);
        if ($products->isEmpty()) {
            return null;
        }

        return $section + [
            'view_all' => $viewAll,
            'data' => ['products' => $products->map(fn ($p) => laly_vue_product_card($p))->values()->all()],
        ];
    }
}

if (! function_exists('laly_vue_home_resolve_section')) {
    function laly_vue_home_resolve_section(array $section): ?array
    {
        $resolver = 'laly_vue_home_resolve_' . $section['type'];
        if (! function_exists($resolver)) {
            return null;
        }
        $resolved = $resolver($section);
        if (! $resolved) {
            return null;
        }
        if (($resolved['title'] ?? '') === '') {
            $resolved['title'] = laly_vue_home_default_title($section);
        }
        unset($resolved['category_id'], $resolved['collection_id'], $resolved['order']);
        if ($resolved['type'] !== 'products') {
            unset($resolved['source'], $resolved['layout']);
        }

        return $resolved;
    }
}

if (! function_exists('laly_vue_home_cache_version')) {
    function laly_vue_home_cache_version(): int
    {
        return (int) Cache::get('laly_vue_home_version', 1);
    }
}

if (! function_exists('laly_vue_home_cache_bump')) {
    function laly_vue_home_cache_bump(): void
    {
        Cache::forever('laly_vue_home_version', laly_vue_home_cache_version() + 1);
    }
}

if (! function_exists('laly_vue_homepage_sections')) {
    /**
     * Resolved, non-empty homepage sections in display order. Cached per locale/currency;
     * the key also hashes the section config so saving Theme options takes effect immediately.
     */
    function laly_vue_homepage_sections(): array
    {
        $config = laly_vue_homepage_sections_config();
        $currency = function_exists('get_application_currency_id') ? get_application_currency_id() : '';
        $optionsHash = md5(json_encode($config) . theme_option('home_features') . theme_option('hero_title')
            . theme_option('hero_stats') . theme_option('home_stats') . theme_option('hero_tag')
            . theme_option('home_banner_1_title') . theme_option('home_banner_2_title'));
        $key = implode(':', ['laly_vue_home', laly_vue_home_cache_version(), app()->getLocale(), $currency, $optionsHash]);

        return Cache::remember($key, LALY_VUE_HOME_CACHE_TTL, function () use ($config) {
            $sections = [];
            foreach ($config as $section) {
                $resolved = laly_vue_home_resolve_section($section);
                if ($resolved) {
                    $sections[] = $resolved;
                }
            }

            return $sections;
        });
    }
}

if (! function_exists('laly_vue_footer_menu')) {
    function laly_vue_footer_menu(string $location = 'footer-menu'): array
    {
        $menu = MenuModel::query()
            ->wherePublished()
            ->whereHas('locations', fn ($q) => $q->where('location', $location))
            ->with(['menuNodes' => fn ($q) => $q->whereNull('parent_id')->orWhere('parent_id', 0), 'menuNodes.reference'])
            ->first();

        if (! $menu) {
            return [];
        }

        return $menu->menuNodes
            ->sortBy('position')
            ->map(function ($node) {
                $url = (string) $node->url;

                return [
                    'title' => (string) $node->title,
                    'url' => laly_vue_is_internal_url($url) ? laly_vue_relative_url($url) : $url,
                    'internal' => laly_vue_is_internal_url($url),
                    'target' => (string) ($node->target ?: '_self'),
                ];
            })
            ->values()
            ->all();
    }
}

if (! function_exists('laly_vue_footer_data')) {
    function laly_vue_footer_data(): array
    {
        $social = [];
        foreach (ThemeSupport::getSocialLinks() as $link) {
            if (! $link->getUrl()) {
                continue;
            }
            $social[] = [
                'name' => $link->getName(),
                'url' => $link->getUrl(),
                'icon' => $link->getIcon(),
                'image' => $link->getImage() ? RvMedia::getImageUrl($link->getImage()) : null,
            ];
        }

        $payment = theme_option('payment_methods');
        $payment = is_string($payment) ? json_decode($payment, true) : $payment;

        return [
            'menu' => laly_vue_footer_menu(),
            'social' => $social,
            'about' => BaseHelper::clean((string) theme_option('footer_about', '')),
            'copyright' => ThemeSupport::getSiteCopyright(),
            'payment_logos' => collect(is_array($payment) ? $payment : [])->filter()->map(fn ($img) => RvMedia::getImageUrl($img))->values()->all(),
            'payment_link' => (string) theme_option('payment_methods_link', ''),
            'whatsapp' => preg_replace('/\D+/', '', (string) theme_option('whatsapp_number', '')),
            'categories' => ProductCategory::query()
                ->wherePublished()
                ->where(fn ($q) => $q->whereNull('parent_id')->orWhere('parent_id', 0))
                ->with('slugable')
                ->orderBy('order')
                ->limit(6)
                ->get()
                ->map(fn ($c) => ['name' => html_entity_decode($c->name), 'slug' => $c->slug])
                ->values()
                ->all(),
        ];
    }
}
