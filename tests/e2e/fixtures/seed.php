<?php
/**
 * Idempotent local test fixtures for the e2e suite. Run via:
 *   php artisan tinker --execute="$(cat tests/e2e/fixtures/seed.php)"
 * LOCAL ONLY. Never run against production: it seeds languages, two customers,
 * a coupon, a CMS page and a variable product.
 */

use Botble\Ecommerce\Models\Customer;
use Botble\Ecommerce\Models\Discount;
use Botble\Ecommerce\Models\Product;
use Botble\Ecommerce\Models\ProductAttribute;
use Botble\Ecommerce\Models\ProductAttributeSet;
use Botble\Ecommerce\Models\ProductVariation;
use Botble\Ecommerce\Models\ProductVariationItem;
use Botble\Language\Models\Language;
use Botble\Page\Models\Page;
use Botble\Slug\Facades\SlugHelper;
use Botble\Slug\Models\Slug;
use Illuminate\Support\Facades\Hash;

$out = [];

// 1. Languages: ar (default, RTL) + en, so locale-prefixed URLs exist like production.
if (Language::query()->count() === 0) {
    Language::query()->create(['lang_name' => 'العربية', 'lang_locale' => 'ar', 'lang_code' => 'ar', 'lang_flag' => 'kw', 'lang_is_default' => 1, 'lang_order' => 0, 'lang_is_rtl' => 1]);
    Language::query()->create(['lang_name' => 'English', 'lang_locale' => 'en', 'lang_code' => 'en', 'lang_flag' => 'us', 'lang_is_default' => 0, 'lang_order' => 1, 'lang_is_rtl' => 0]);
    $out[] = 'languages: created ar(default)+en';
} else {
    $out[] = 'languages: ' . Language::query()->pluck('lang_code')->implode(',');
}

// 2. Two activated, phone-verified customers (IDOR pairs).
foreach ([1 => '96550000101', 2 => '96550000102'] as $n => $phone) {
    $email = "customer_{$n}@example.com";
    $c = Customer::query()->where('email', $email)->first();
    if (! $c) {
        $c = Customer::query()->create(['name' => "E2E Customer {$n}", 'email' => $email, 'phone' => $phone, 'password' => Hash::make('12345678'), 'status' => 'activated']);
    }
    // Always reset the password (bcrypt) so a corrupted/legacy value can't break login.
    $c->forceFill(['password' => Hash::make('12345678'), 'status' => 'activated', 'confirmed_at' => now(), 'phone_verified_at' => now(), 'profile_completed_at' => now()])->save();
    // Give each customer a saved address (targets for IDOR / mass-assignment probes).
    if (class_exists(\Botble\Ecommerce\Models\Address::class) && \Botble\Ecommerce\Models\Address::query()->where('customer_id', $c->id)->count() === 0) {
        \Botble\Ecommerce\Models\Address::query()->create(['customer_id' => $c->id, 'name' => "E2E Customer {$n}", 'phone' => $phone, 'email' => $email, 'country' => 'KW', 'state' => 'Al Asimah', 'city' => 'Kuwait City', 'address' => "Block {$n}, Street 2, House 3", 'zip_code' => '00000', 'is_default' => true]);
    }
    $out[] = "customer_{$n}: id={$c->id}";
}

// 3. Coupon E2E10: 10% off, unlimited, all orders.
$d = Discount::query()->firstOrCreate(['code' => 'E2E10'], [
    'title' => 'E2E 10%', 'type' => 'coupon', 'type_option' => 'percentage', 'value' => 10,
    'target' => 'all-orders', 'start_date' => now()->subDay(), 'quantity' => 1000, 'total_used' => 0,
    'can_use_with_promotion' => 1, 'can_use_with_flash_sale' => 1, 'discount_on' => 'once', 'apply_via_url' => 0, 'display_at_checkout' => 1,
]);
$out[] = "coupon: {$d->code}";

// 4. A published CMS page.
$page = Page::query()->where('name', 'E2E Page')->first();
if (! $page) {
    $page = Page::query()->create(['name' => 'E2E Page', 'content' => '<p>E2E page content.</p>', 'status' => 'published', 'user_id' => 1]);
    Slug::query()->create(['key' => 'e2e-page', 'reference_type' => Page::class, 'reference_id' => $page->id, 'prefix' => SlugHelper::getPrefix(Page::class)]);
}
$out[] = 'page: e2e-page';

// 5. A variable product (Color: Red/Blue) with two variations.
$parent = Product::query()->where('name', 'E2E Variable')->first();
if (! $parent) {
    $set = ProductAttributeSet::query()->firstOrCreate(['slug' => 'e2e-color'], ['title' => 'E2E Color', 'status' => 'published', 'order' => 0, 'display_layout' => 'visual', 'is_searchable' => 1, 'is_comparable' => 1, 'is_use_in_product_listing' => 1]);
    $red = ProductAttribute::query()->firstOrCreate(['slug' => 'e2e-red'], ['title' => 'Red', 'color' => '#ff0000', 'order' => 0, 'attribute_set_id' => $set->id, 'is_default' => 1]);
    $blue = ProductAttribute::query()->firstOrCreate(['slug' => 'e2e-blue'], ['title' => 'Blue', 'color' => '#0000ff', 'order' => 1, 'attribute_set_id' => $set->id, 'is_default' => 0]);

    $parent = Product::query()->create(['name' => 'E2E Variable', 'description' => 'Variable product for e2e.', 'status' => 'published', 'price' => 100, 'quantity' => 10, 'with_storehouse_management' => 1, 'is_variation' => 0, 'sku' => 'E2E-VAR']);
    Slug::query()->create(['key' => 'e2e-variable', 'reference_type' => Product::class, 'reference_id' => $parent->id, 'prefix' => SlugHelper::getPrefix(Product::class)]);
    $parent->productAttributeSets()->sync([$set->id]);

    foreach ([['Red', $red, 100, 5, 1], ['Blue', $blue, 120, 5, 0]] as [$label, $attr, $price, $qty, $isDefault]) {
        $v = Product::query()->create(['name' => "E2E Variable ({$label})", 'status' => 'published', 'price' => $price, 'quantity' => $qty, 'with_storehouse_management' => 1, 'is_variation' => 1, 'sku' => 'E2E-VAR-' . strtoupper($label)]);
        $pv = ProductVariation::query()->create(['product_id' => $v->id, 'configurable_product_id' => $parent->id, 'is_default' => $isDefault]);
        ProductVariationItem::query()->create(['attribute_id' => $attr->id, 'variation_id' => $pv->id]);
    }
}
$out[] = "variable product: id={$parent->id} slug=e2e-variable";

// 6. Reset the "locked" state helper flag used by auth-gate tests.
Customer::query()->where('email', 'customer_1@example.com')->update(['status' => 'activated']);

echo implode("\n", $out) . "\n";
