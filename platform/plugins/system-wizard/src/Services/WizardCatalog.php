<?php

namespace Botble\SystemWizard\Services;

use Botble\Base\Enums\BaseStatusEnum;
use Botble\Ecommerce\Models\Product;
use Illuminate\Support\Facades\Cache;

/**
 * Maps the admin-selected products (system-wizard settings, keys sw_*) to the catalog
 * shape the wizard engine uses. Shared by the storefront preview and the server-side
 * RecommendationService so both price from the same data.
 */
class WizardCatalog
{
    public const CACHE_KEY = 'system_wizard_catalog_v2';

    public const HDD_SIZES = [1, 2, 4, 6, 8, 12, 16];

    public const POE_PORTS = [4, 8, 16, 24];

    public const NVR_CHANNELS = [8, 16, 32];

    public const TIERS = ['basic', 'pro', 'prem'];

    /** Storage per camera per day (GB) by package quality. */
    public const GB_PER_DAY = ['basic' => 12, 'pro' => 20, 'prem' => 35];

    public static function forget(): void
    {
        Cache::forget(self::CACHE_KEY);
    }

    public function get(): array
    {
        return Cache::remember(self::CACHE_KEY, now()->addMinutes(10), fn () => $this->build());
    }

    protected function build(): array
    {
        $keys = $this->productSettingKeys();
        $ids = array_filter(array_map(fn ($key) => (int) setting($key), $keys));

        // One query for every mapped product instead of one find() per slot.
        $products = Product::query()
            ->whereIn('id', array_unique($ids))
            ->get()
            ->keyBy('id');

        $item = function (string $key) use ($products): array {
            $product = $products->get((int) setting($key));

            if (! $product || $product->status != BaseStatusEnum::PUBLISHED || $product->isOutOfStock()) {
                return ['name' => 'غير محدد', 'price' => 0, 'available' => false];
            }

            return [
                'name' => html_entity_decode($product->name),
                'price' => (float) ($product->front_sale_price ?: $product->price),
                'available' => true,
                'product_id' => $product->getKey(),
            ];
        };

        $price = fn (string $key) => $item($key)['price'];

        $byTier = fn (string $prefix) => array_combine(
            self::TIERS,
            array_map(fn ($tier) => $item("{$prefix}_{$tier}"), self::TIERS)
        );

        $camera = [];
        foreach (self::TIERS as $tier) {
            $camera[$tier] = [
                'in' => $item("sw_cam_{$tier}_in"),
                'out' => $item("sw_cam_{$tier}_out"),
                'gbDay' => self::GB_PER_DAY[$tier],
            ];
        }

        $nvr = [];
        foreach (self::NVR_CHANNELS as $channels) {
            foreach (self::TIERS as $tier) {
                $nvr[$channels][$tier] = $price("sw_nvr_{$channels}_{$tier}");
            }
        }

        return [
            'camera' => $camera,
            'ptz' => $item('sw_ptz'),
            'nvr' => $nvr,
            'hdd' => [
                'sizes' => self::HDD_SIZES,
                'price' => array_combine(self::HDD_SIZES, array_map(fn ($tb) => $price("sw_hdd_{$tb}tb"), self::HDD_SIZES)),
            ],
            'poeSwitch' => [
                'ports' => self::POE_PORTS,
                'price' => array_combine(self::POE_PORTS, array_map(fn ($p) => $price("sw_poe_{$p}"), self::POE_PORTS)),
            ],
            'ap' => $byTier('sw_ap') + ['controller' => $item('sw_ap_controller')],
            'intercom' => $byTier('sw_intercom'),
            'alarm' => $byTier('sw_alarm'),
            'router4g' => $item('sw_router4g'),
            'netPoint' => $byTier('sw_netpoint'),
            'tvPoint' => $byTier('sw_tvpoint'),
            'rack' => $byTier('sw_rack'),
            'installPerPoint' => (float) setting('sw_install_per_point', 8),
            'whatsappNumber' => preg_replace('/\D/', '', (string) setting('sw_whatsapp_number', '')),
        ];
    }

    /**
     * @return array<int, string>
     */
    protected function productSettingKeys(): array
    {
        $keys = ['sw_ptz', 'sw_ap_controller', 'sw_router4g'];

        foreach (self::TIERS as $tier) {
            array_push(
                $keys,
                "sw_cam_{$tier}_in",
                "sw_cam_{$tier}_out",
                "sw_ap_{$tier}",
                "sw_intercom_{$tier}",
                "sw_alarm_{$tier}",
                "sw_netpoint_{$tier}",
                "sw_tvpoint_{$tier}",
                "sw_rack_{$tier}"
            );

            foreach (self::NVR_CHANNELS as $channels) {
                $keys[] = "sw_nvr_{$channels}_{$tier}";
            }
        }

        foreach (self::HDD_SIZES as $tb) {
            $keys[] = "sw_hdd_{$tb}tb";
        }

        foreach (self::POE_PORTS as $ports) {
            $keys[] = "sw_poe_{$ports}";
        }

        return $keys;
    }
}
