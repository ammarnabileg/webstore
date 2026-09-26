# Homepage sections (laly-vue)

The storefront homepage is assembled from an ordered list of sections that the admin manages
in **Appearance → Theme options**. No code change is needed to reorder, hide, rename or add
sections.

## How it works

```
Theme options (repeater "homepage_sections")
        ↓  platform/themes/laly-vue/functions/homepage.php
laly_vue_homepage_sections()   – normalise config → resolve each section → drop empty ones → cache
        ↓  GET /ajax/vue/home-sections
components/home/HomeSections.vue – renders each section by type (registry), in order
```

* `homepage_id` (CMS page as homepage) still takes precedence: when it is set and published the
  page is built from shortcodes exactly as before, and the section list is not used.
* When the section list is empty the default layout is used
  (slider → features → wizard CTA → categories → banners → flash sale → featured → best sellers → latest).
* A section that resolves to no data (no featured categories, no products, expired flash sale,
  no slider **and** hero fallback disabled…) is omitted entirely: no title, no empty grid.
* The resolved payload is cached for 5 minutes per language/currency. The cache key includes the
  section config, so saving Theme options applies immediately; saving a product, category,
  collection, flash sale, slider or menu bumps the cache version.

## Section types and sources

| Type | What it shows | Settings used |
|---|---|---|
| `slider` | Simple Sliders → slider with key **`home-slider`** (desktop image, mobile image, title, description, link, button text). Falls back to the static hero (Theme options → *Homepage: Hero fallback*) when the slider has no published items. | enabled, order |
| `features` | Trust badges from *Homepage: Features bar* | enabled, order |
| `wizard_cta` | "Find the right system" card (*Homepage: Wizard CTA*) | enabled, order |
| `categories` | Root categories marked **Featured** | enabled, order, title, subtitle, limit |
| `banners` | *Homepage: Banners* (internal links open inside the app) | enabled, order |
| `flash_sale` | First active flash sale with products, with a live countdown | enabled, order, title, subtitle, limit |
| `products` | Product grid/row from a **source** | enabled, order, title, subtitle, source, category, collection, limit, layout |

Product sources: `featured` (products marked Featured), `latest`, `best_selling`
(quantity sold in finished, non-cancelled orders — `ec_order_product` joined to `ec_orders`;
variation sales count for the parent product), `category` (a category and its children),
`collection`.

Adding a type: add it to `LALY_VUE_HOME_TYPES`, write `laly_vue_home_resolve_<type>()` and map it
in `HomeSections.vue`. Adding a product source: add it to `LALY_VUE_HOME_SOURCES` and a case in
`laly_vue_home_products_for()`.

## Admin: managing the homepage

1. **Appearance → Theme options → Homepage: Sections**. Click *Add* for each section, choose the
   type, set **Enabled**, **Order** (1 = top), an optional title/subtitle, and for *Products* the
   source (+ category or collection), the item limit and the layout (grid / horizontal scroll).
   Save. Order numbers decide the position; sections with the same number keep their row order.
2. **Slider**: Plugins → Simple Sliders → create a slider with key `home-slider`, add items with a
   desktop image, a mobile image, a link and (optionally) button text.
3. **Featured categories / products**: edit the category or product and tick *Featured*.
4. **Flash sale**: Ecommerce → Flash sales (published, end date in the future, with products).
5. **Features bar**: Theme options → *Homepage: Features bar* (icon class, title, description).
6. **Banners**: Theme options → *Homepage: Banners*.
7. **Hero fallback** (only when no slider): Theme options → *Homepage: Hero fallback*.
8. **Footer**: Appearance → Menus → assign a menu to location **Footer menu**;
   Theme options → *Footer* (about text, payment logos), *Store contact* (phone, email, address),
   *Social links*, *General → Copyright* (`%Y` = current year).
9. Titles are per language: switch the language selector at the top of the Theme options page to
   enter the English titles; anything left empty falls back to the default-language value or to
   the built-in translation.
