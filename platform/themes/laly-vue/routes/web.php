<?php

use Botble\Theme\Facades\Theme;
use Illuminate\Support\Facades\Route;
use Botble\Ecommerce\Repositories\Interfaces\ProductInterface;
use Botble\Ecommerce\Repositories\Interfaces\ProductCategoryInterface;
use Illuminate\Http\Request;
use Botble\Media\Facades\RvMedia;
use Botble\Ecommerce\Facades\Cart;
use Botble\Slug\Facades\SlugHelper;

Theme::registerRoutes(function (): void {

    // Internal Vue API Routes
    Route::group(['prefix' => 'ajax/vue', 'as' => 'public.ajax.vue.', 'middleware' => ['web', 'core']], function (): void {

        // Storefront notifications and FCM token routes live in the laly-notifications plugin.

        Route::get('products', function (Request $request, ProductInterface $productRepository) {
            $params = [
                'paginate' => [
                    'per_page' => min(max($request->integer('per_page', 10), 1), 60),
                    'current_paged' => $request->integer('page', 1),
                ],
                'with' => ['slugable', 'productLabels', 'productCollections', 'tags', 'metadata'],
            ];

            $filters = [];

            // Keyword Search
            if ($request->filled('q') && is_string($request->input('q'))) {
                $filters['keyword'] = mb_substr($request->input('q'), 0, 100);
            }

            // Category Filter
            if ($request->filled('category')) {
                $categoryInput = $request->input('category');
                $filters['categories'] = is_array($categoryInput) ? $categoryInput : explode(',', $categoryInput);
            }

            // Collection / tag filters (ids, comma-separated or array). collection_id is used by shortcodes.
            foreach (['collections' => 'collections', 'collection_id' => 'collections', 'tags' => 'tags'] as $input => $filterKey) {
                if ($request->filled($input)) {
                    $value = $request->input($input);
                    $ids = array_values(array_filter(array_map('intval', is_array($value) ? $value : explode(',', (string) $value))));
                    $filters[$filterKey] = array_values(array_unique(array_merge($filters[$filterKey] ?? [], $ids)));
                }
            }

            // Sorting
            $sorts = [
                'newest' => ['ec_products.created_at' => 'DESC'],
                'price_asc' => ['ec_products.price' => 'ASC'],
                'price_desc' => ['ec_products.price' => 'DESC'],
                'popular' => ['ec_products.views' => 'DESC'],
            ];
            $sort = is_string($request->input('sort')) ? $request->input('sort') : '';
            if (isset($sorts[$sort])) {
                $params['order_by'] = $sorts[$sort];
            }

            // Attribute Filter
            if ($request->filled('attributes')) {
                $attrsInput = $request->input('attributes');
                $filters['attributes'] = is_array($attrsInput) ? $attrsInput : explode(',', $attrsInput);
            }

            // Price range (values are in the display currency; the repository converts to the base rate).
            if ($request->filled('min_price') && is_numeric($request->input('min_price'))) {
                $filters['min_price'] = max(0, (float) $request->input('min_price'));
            }
            if ($request->filled('max_price') && is_numeric($request->input('max_price'))) {
                $filters['max_price'] = max(0, (float) $request->input('max_price'));
            }

            // Use getProducts to properly apply the filters with default conditions
            $products = $productRepository->getProducts($params, $filters);

            $data = [];
            foreach ($products as $product) {
                $data[] = laly_vue_product_card($product) + [
                    'tags' => $product->tags->map(function ($tag) {
                        return ['id' => $tag->id, 'name' => $tag->name];
                    }),
                    'collections' => $product->productCollections->map(function ($col) {
                        return ['id' => $col->id, 'name' => $col->name];
                    }),
                ];
            }
            $meta = method_exists($products, 'currentPage') ? [
                'current_page' => $products->currentPage(),
                'last_page' => $products->lastPage(),
                'per_page' => $products->perPage(),
                'total' => $products->total(),
            ] : null;

            return response()->json(['data' => $data, 'meta' => $meta]);
        });

        // Get single product by slug
        Route::get('products/{slug}', function (string $slug, ProductInterface $productRepository) {
            $slugModel = SlugHelper::getSlug($slug, SlugHelper::getPrefix(\Botble\Ecommerce\Models\Product::class), \Botble\Ecommerce\Models\Product::class);
            if (!$slugModel) {
                return response()->json(['message' => 'Product not found'], 404);
            }
            $product = $productRepository->findById($slugModel->reference_id, ['slugable', 'productLabels', 'productCollections', 'tags']);
            if (!$product || $product->status != \Botble\Base\Enums\BaseStatusEnum::PUBLISHED) {
                return response()->json(['message' => 'Product not found'], 404);
            }

            $variationInfo = laly_vue_variation_info($product);

            return response()->json([
                'data' => laly_vue_product_card($product) + [
                    'has_variations' => $variationInfo !== null,
                    'variation_info' => $variationInfo,
                    'images' => array_map(function ($img) {
                        return RvMedia::getImageUrl($img, null, false, RvMedia::getDefaultImage());
                    }, is_array($product->images) ? $product->images : []),
                    'description' => BaseHelper::clean($product->description),
                    'content' => BaseHelper::clean($product->content),
                    'tags' => $product->tags->map(function ($tag) {
                        return ['id' => $tag->id, 'name' => $tag->name];
                    }),
                    'collections' => $product->productCollections->map(function ($col) {
                        return ['id' => $col->id, 'name' => $col->name];
                    }),
                ],
            ]);
        });

        $findPublishedProductBySlug = function (string $slug) {
            $slugModel = SlugHelper::getSlug($slug, SlugHelper::getPrefix(\Botble\Ecommerce\Models\Product::class), \Botble\Ecommerce\Models\Product::class);

            return $slugModel
                ? \Botble\Ecommerce\Models\Product::query()
                    ->where('status', \Botble\Base\Enums\BaseStatusEnum::PUBLISHED)
                    ->find($slugModel->reference_id)
                : null;
        };

        Route::get('products/{slug}/related', function (string $slug) use ($findPublishedProductBySlug) {
            $product = $findPublishedProductBySlug($slug);
            if (!$product) {
                return response()->json(['data' => []]);
            }

            $related = collect(get_related_products($product, 8) ?? []);
            // Cards read labels and payment metadata: load them in one query each, not per product.
            if ($related->isNotEmpty()) {
                (new \Illuminate\Database\Eloquent\Collection($related->all()))->loadMissing(['productLabels', 'metadata']);
            }

            return response()->json(['data' => collect($related)->map(fn ($item) => laly_vue_product_card($item))->values()]);
        });

        Route::get('products/{slug}/reviews', function (string $slug) use ($findPublishedProductBySlug) {
            $product = $findPublishedProductBySlug($slug);
            if (!$product || !\Botble\Ecommerce\Facades\EcommerceHelper::isReviewEnabled()) {
                return response()->json(['data' => []]);
            }

            $reviews = \Botble\Ecommerce\Models\Review::query()
                ->with('user')
                ->where('product_id', $product->id)
                ->where('status', \Botble\Base\Enums\BaseStatusEnum::PUBLISHED)
                ->latest()
                ->limit(20)
                ->get();

            return response()->json(['data' => $reviews->map(fn ($review) => [
                'id' => $review->id,
                'customer_name' => $review->user_name ?: $review->customer_name,
                'star' => (int) $review->star,
                'comment' => $review->comment,
                'created_at' => $review->created_at?->toDateString(),
            ])->values()]);
        });

        // Get slider by key
        Route::get('sliders/{key}', function (string $key) {
            if (!is_plugin_active('simple-slider')) {
                return response()->json(['data' => []]);
            }

            $slider = \Botble\SimpleSlider\Models\SimpleSlider::where('key', $key)
                ->where('status', 'published')
                ->first();

            if (!$slider) {
                return response()->json(['data' => []]);
            }

            $items = \Botble\SimpleSlider\Models\SimpleSliderItem::where('simple_slider_id', $slider->id)
                ->orderBy('order', 'ASC')
                ->get()
                ->map(function ($item) {
                    return [
                        'id' => $item->id,
                        'title' => $item->title,
                        'description' => $item->description,
                        'link' => $item->link,
                        'image' => RvMedia::getImageUrl($item->image, null, false, RvMedia::getDefaultImage()),
                    ];
                });

            return response()->json(['data' => $items]);
        });

        // Get homepage collections
        Route::get('home-collections', function () {
            $data = [];
            
            $formatProduct = fn ($product) => laly_vue_product_card($product);

            $baseQuery = \Botble\Ecommerce\Models\Product::query()
                ->where('status', 'published')
                ->where('is_variation', false)
                ->with(['slugable', 'productLabels', 'metadata']);

            $featured = (clone $baseQuery)->where('is_featured', 1)->orderByDesc('created_at')->limit(8)->get();
            $data['featured_products'] = $featured->map($formatProduct);

            $topRated = (clone $baseQuery)->orderByDesc('views')->limit(8)->get();
            $data['top_products'] = $topRated->map($formatProduct);

            $trending = (clone $baseQuery)->orderByDesc('created_at')->limit(8)->get();
            $data['weekly_best_sellers'] = $trending->map($formatProduct);

            // Flash Sales
            $flashSales = \Botble\Ecommerce\Models\FlashSale::query()
                ->where('status', 'published')
                ->where('end_date', '>', now())
                ->with(['products' => function ($query) {
                    $query->where('status', 'published')->where('is_variation', false)->with(['slugable', 'productLabels', 'metadata']);
                }])
                ->get();
                
            $data['flash_sales'] = $flashSales->map(function($fs) use ($formatProduct) {
                return [
                    'id' => $fs->id,
                    'name' => $fs->name,
                    'end_date' => $fs->end_date,
                    'products' => $fs->products->map($formatProduct)
                ];
            });

            return response()->json(['data' => $data]);
        });

        // Get homepage content
        Route::get('homepage', function () {
            $homepageId = theme_option('homepage_id');
            // No CMS homepage assigned is a normal state (the SPA renders its own default blocks);
            // return 200 + null so the storefront does not log a console error on every home load.
            if (!$homepageId) {
                return response()->json(['data' => null]);
            }
            $page = \Botble\Page\Models\Page::find($homepageId);
            if (!$page || $page->status != 'published') {
                return response()->json(['data' => null]);
            }

            return response()->json([
                'data' => [
                    'id' => $page->id,
                    'name' => $page->name,
                    'content' => BaseHelper::clean($page->content),
                ]
            ]);
        });

        // Get single CMS page by slug
        Route::get('pages/{slug}', function (string $slug) {
            $slugModel = SlugHelper::getSlug($slug, SlugHelper::getPrefix(\Botble\Page\Models\Page::class), \Botble\Page\Models\Page::class);
            if (!$slugModel) {
                return response()->json(['message' => 'Page not found'], 404);
            }
            $page = \Botble\Page\Models\Page::find($slugModel->reference_id);
            if (!$page || $page->status != 'published') {
                return response()->json(['message' => 'Page not found'], 404);
            }

            return response()->json([
                'data' => [
                    'id' => $page->id,
                    'name' => $page->name,
                    'content' => BaseHelper::clean($page->content),
                ]
            ]);
        });

        Route::get('product-categories', function (ProductCategoryInterface $categoryRepository) {
            $categories = $categoryRepository->advancedGet([
                'condition' => ['status' => 'published'],
                'with' => ['translations', 'slugable'],
                'order_by' => ['order' => 'ASC', 'created_at' => 'DESC'],
            ]);
            $data = [];
            foreach ($categories as $category) {
                $data[] = [
                    'id' => $category->id,
                    'parent_id' => $category->parent_id,
                    'name' => html_entity_decode($category->name),
                    'slug' => $category->slug ?: ($category->slugable ? $category->slugable->key : ''),
                    'url' => $category->url,
                    'image' => RvMedia::getImageUrl($category->image, 'thumb', false, RvMedia::getDefaultImage()),
                    'icon' => $category->icon ?: $category->icon_font,
                    'icon_image' => $category->icon_image ? RvMedia::getImageUrl($category->icon_image) : null,
                    'is_featured' => $category->is_featured,
                ];
            }
            return response()->json(['data' => $data]);
        });

        Route::get('filters', function (Request $request) {
            $query = \Botble\Ecommerce\Models\ProductAttributeSet::where('status', 'published')
                ->with([
                    'attributes' => function ($q) {
                        $q->orderBy('order', 'ASC');
                    }
                ])
                ->orderBy('order', 'ASC');

            if ($request->filled('category')) {
                $categoryInput = $request->input('category');
                $categoryIds = is_array($categoryInput) ? $categoryInput : explode(',', $categoryInput);

                // Fetch attribute sets assigned to these categories
                $query->whereHas('categories', function ($subQ) use ($categoryIds) {
                    $subQ->whereIn('ec_product_categorizables.category_id', $categoryIds);
                });
            }

            $attributeSets = $query->get();

            $attributeData = [];
            foreach ($attributeSets as $set) {
                $attrs = [];
                foreach ($set->attributes as $attr) {
                    $attrs[] = [
                        'id' => $attr->id,
                        'title' => $attr->title,
                        'color' => $attr->color,
                        'image' => $attr->image ? RvMedia::getImageUrl($attr->image) : null,
                    ];
                }
                $attributeData[] = [
                    'id' => $set->id,
                    'title' => $set->title,
                    'attributes' => $attrs,
                ];
            }

            $data = [
                'attributes' => $attributeData,
                'collections' => \Botble\Ecommerce\Models\ProductCollection::where('status', 'published')->get()->map(function ($c) {
                    return ['id' => $c->id, 'title' => $c->name];
                }),
                'tags' => \Botble\Ecommerce\Models\ProductTag::where('status', 'published')->get()->map(function ($t) {
                    return ['id' => $t->id, 'title' => $t->name];
                }),
            ];
            return response()->json(['data' => $data]);
        });

        Route::get('cart', function () {
            $items = [];
            foreach (Cart::instance('cart')->content() as $item) {
                $items[] = [
                    'id' => $item->id,
                    'rowId' => $item->rowId,
                    'name' => $item->name,
                    'qty' => $item->qty,
                    'price' => $item->price,
                    'price_format' => format_price($item->price),
                    'product_image' => RvMedia::getImageUrl($item->options->image ?? ''),
                ];
            }
            return response()->json([
                'data' => [
                    'items' => $items,
                    'count' => Cart::instance('cart')->count(),
                    'sub_total_format' => format_price(Cart::instance('cart')->rawSubTotal()),
                    'tax_amount' => Cart::instance('cart')->rawTax(),
                    'tax_amount_format' => format_price(Cart::instance('cart')->rawTax()),
                    'total_format' => format_price(Cart::instance('cart')->rawTotal()),
                ]
            ]);
        });

        Route::post('cart/add', function (Request $request) {
            $validated = $request->validate([
                'id' => ['required', 'integer', 'min:1'],
                'qty' => ['nullable', 'integer', 'min:1', 'max:100'],
            ]);
            $qty = (int) ($validated['qty'] ?? 1);

            $product = \Botble\Ecommerce\Models\Product::query()->find($validated['id']);
            if (!$product || $product->status != \Botble\Base\Enums\BaseStatusEnum::PUBLISHED) {
                return response()->json(['error' => true, 'message' => 'Product not found'], 404);
            }

            // Same rule as the stock cart: a parent product with variations is added as its default variation.
            if ($product->variations->isNotEmpty() && !$product->is_variation && $product->defaultVariation?->product) {
                $product = $product->defaultVariation->product;
            }

            // A variation id must not bypass the parent's draft/pending status.
            $parent = $product->is_variation ? $product->original_product : $product;
            if (!$parent || $parent->status != \Botble\Base\Enums\BaseStatusEnum::PUBLISHED) {
                return response()->json(['error' => true, 'message' => 'Product not found'], 404);
            }

            if ($product->isOutOfStock()) {
                return response()->json(['error' => true, 'message' => 'Product is out of stock'], 422);
            }

            if ($product->with_storehouse_management && !$product->allow_checkout_when_out_of_stock) {
                $inCart = Cart::instance('cart')->content()->where('id', $product->id)->sum('qty');
                if ($inCart + $qty > $product->quantity) {
                    return response()->json(['error' => true, 'message' => 'Not enough stock'], 422);
                }
            }

            // Delegate to Botble so price, tax, SKU and variation data are computed server-side.
            // Only qty is forwarded; client-supplied options/extras are not trusted here.
            try {
                \Botble\Ecommerce\Facades\OrderHelper::handleAddCart($product, new Request(['qty' => $qty]));
            } catch (\Throwable $e) {
                return response()->json(['error' => true, 'message' => 'Could not add product to cart'], 422);
            }

            return response()->json(['error' => false, 'message' => 'Added to cart']);
        });

        Route::delete('cart/remove/{id}', function (string $id) {
            Cart::instance('cart')->remove($id);
            return response()->json(['error' => false, 'message' => 'Removed from cart']);
        });

        Route::post('cart/update', function (Request $request) {
            $validated = $request->validate([
                'rowId' => ['required', 'string', 'max:64'],
                'qty' => ['required', 'integer', 'min:1', 'max:100'],
            ]);
            $item = Cart::instance('cart')->content()->get($validated['rowId']);
            if (!$item) {
                return response()->json(['error' => true, 'message' => 'Item not found'], 404);
            }
            // Same stock rule as cart/add.
            $product = \Botble\Ecommerce\Models\Product::query()->find($item->id);
            if (!$product || $product->isOutOfStock()) {
                return response()->json(['error' => true, 'message' => 'Product is out of stock'], 422);
            }
            $parent = $product->is_variation ? $product->original_product : $product;
            if (!$parent || $parent->status != \Botble\Base\Enums\BaseStatusEnum::PUBLISHED) {
                return response()->json(['error' => true, 'message' => 'Product is not available'], 422);
            }
            if ($product->with_storehouse_management && !$product->allow_checkout_when_out_of_stock) {
                $otherRows = Cart::instance('cart')->content()
                    ->filter(fn ($row) => $row->id == $product->id && $row->rowId !== $item->rowId)
                    ->sum('qty');
                if ($otherRows + (int) $validated['qty'] > $product->quantity) {
                    return response()->json(['error' => true, 'message' => 'Not enough stock'], 422);
                }
            }
            Cart::instance('cart')->update($validated['rowId'], (int) $validated['qty']);
            return response()->json(['error' => false, 'message' => 'Cart updated']);
        });

    });

    // POST logout so the SPA does not rely on a GET anchor (which is embeddable cross-site).
    Route::post('logout', function () {
        auth('customer')->logout();
        request()->session()->invalidate();
        request()->session()->regenerateToken();

        return response()->json(['error' => false, 'redirect' => url('/')]);
    })->name('public.logout.post');

    // SPA Catch-All Routes: Force Botble to return the Vue layout when user manually reloads on these pages
    $spaRoutes = [
        'products' => 'public.products',
        'categories' => 'public.categories',
        'cart' => 'public.cart',
        'search' => 'public.search',
        'profile' => 'public.profile',
        'notifications' => 'public.notifications',
        'project-wizard' => 'public.system-wizard',
        // NOTE: /wishlist is served by the ecommerce plugin's wishlist/{code?} route (registered
        // first, so it wins). It is wrapped by the Blade chrome so it is navigable; a true SPA
        // wishlist with server sync is Tier 2.5.
    ];
    foreach ($spaRoutes as $spaRoute => $name) {
        Route::get($spaRoute, function () {
            return Theme::scope('page')->render();
        })->name($name);
    }

    // SEO-Optimized SPA Route for Single Product
    Route::get('product/{slug}', function (string $slug, ProductInterface $productRepository) {
        $slugModel = SlugHelper::getSlug($slug, SlugHelper::getPrefix(\Botble\Ecommerce\Models\Product::class), \Botble\Ecommerce\Models\Product::class);
        
        if (!$slugModel) {
            abort(404);
        }

        $product = $productRepository->findById($slugModel->reference_id);
        
        if (!$product || $product->status != \Botble\Base\Enums\BaseStatusEnum::PUBLISHED) {
            abort(404);
        }

        $seoMeta = $product->getMetaData('seo_meta', true);
        $description = $seoMeta['seo_description'] ?? '';
        
        if (empty($description)) {
            $desc = str_replace(['<br>', '<br/>', '<br />', '</p>'], ' ', (string) $product->description);
            $desc = strip_tags($desc);
            $desc = preg_replace('/[\x{1F600}-\x{1F64F}\x{1F300}-\x{1F5FF}\x{1F680}-\x{1F6FF}\x{2600}-\x{26FF}\x{2700}-\x{27BF}\x{1F900}-\x{1F9FF}\x{1FA70}-\x{1FAFF}]/u', '', $desc);
            $desc = trim(preg_replace('/\s+/', ' ', $desc));
            $description = \Illuminate\Support\Str::limit($desc, 155);
        }

        \Botble\SeoHelper\Facades\SeoHelper::setTitle($product->name)
            ->setDescription($description);
        
        \Botble\SeoHelper\Facades\SeoHelper::meta()->setUrl(url()->current());
        \Botble\SeoHelper\Facades\SeoHelper::meta()->addMeta('property:og:site_name', theme_option('site_title'));
        
        if ($product->image) {
            \Botble\SeoHelper\Facades\SeoHelper::setImage(RvMedia::getImageUrl($product->image));
        }

        // Add Schema.org JSON-LD for rich snippets
        $ssrPrice = $product->front_sale_price ?: $product->price;
        $product->loadMissing('categories.slugable');
        $schema = [
            '@context' => 'https://schema.org/',
            '@type' => 'Product',
            'name' => html_entity_decode($product->name),
            'image' => [RvMedia::getImageUrl($product->image, null, false, RvMedia::getDefaultImage())],
            'description' => $description,
            'offers' => [
                '@type' => 'Offer',
                'url' => url()->current(),
                'priceCurrency' => get_application_currency()->title ?? 'KWD',
                'price' => $ssrPrice,
                'itemCondition' => 'https://schema.org/NewCondition',
                'availability' => $product->isOutOfStock() ? 'https://schema.org/OutOfStock' : 'https://schema.org/InStock',
            ]
        ];
        Theme::asset()->container('header')->writeContent('schema-org-product', '<script type="application/ld+json">' . json_encode($schema, JSON_UNESCAPED_UNICODE) . '</script>');

        // Poor Man's SSR HTML
        $formattedPrice = format_price($ssrPrice);
        
        $ssrHtml = '<div class="ssr-product-container" style="padding:20px; max-width:1200px; margin:0 auto; font-family:sans-serif;">';
        $ssrHtml .= '<div style="display:flex; flex-wrap:wrap; gap:20px;">';
        $ssrHtml .= '<div style="flex:1; min-width:300px;"><img src="'.RvMedia::getImageUrl($product->image).'" alt="'.htmlentities($product->name).'" width="600" height="600" style="width:100%; height:auto; object-fit:cover; border-radius:8px;"></div>';
        $ssrHtml .= '<div style="flex:1; min-width:300px;">';
        $ssrHtml .= '<h1>'.htmlentities($product->name).'</h1>';
        $ssrHtml .= '<h2 style="color:#d32f2f; font-size:24px;">'.$formattedPrice.'</h2>';
        $ssrHtml .= '<div class="product-description" style="margin-top:20px; line-height:1.6;">'.BaseHelper::clean($product->description).'</div>';
        
        // Category Links (Breadcrumb equivalent)
        if ($product->categories && $product->categories->count()) {
            $ssrHtml .= '<div style="margin-top:20px;"><strong>Categories:</strong> <ul>';
            foreach ($product->categories as $category) {
                $ssrHtml .= '<li><a href="'.url('product-categories/'.$category->slug).'">'.htmlentities($category->name).'</a></li>';
            }
            $ssrHtml .= '</ul></div>';
        }
        
        // Related Products Links
        $relatedProducts = \Botble\Ecommerce\Models\Product::where('status', \Botble\Base\Enums\BaseStatusEnum::PUBLISHED)
            ->where('id', '!=', $product->id)
            ->where('is_variation', false)
            ->limit(4)->get(); // basic related fetch for SEO crawling
        if ($relatedProducts->count()) {
            $ssrHtml .= '<div style="margin-top:40px;"><strong>Related Products:</strong> <ul style="display:flex; gap:10px; list-style:none; padding:0;">';
            foreach ($relatedProducts as $related) {
                $ssrHtml .= '<li><a href="'.url('product/'.$related->slug).'">'.htmlentities($related->name).'</a></li>';
            }
            $ssrHtml .= '</ul></div>';
        }
        
        $ssrHtml .= '</div></div></div>';

        return Theme::scope('page', ['ssrHtml' => $ssrHtml])->render();
    })->name('public.product');

    // SEO-Optimized SPA Route for Categories
    Route::get('product-categories/{slug}', function (string $slug, ProductCategoryInterface $categoryRepository) {
        $slugModel = SlugHelper::getSlug($slug, SlugHelper::getPrefix(\Botble\Ecommerce\Models\ProductCategory::class), \Botble\Ecommerce\Models\ProductCategory::class);
        
        if (!$slugModel) {
            abort(404);
        }

        $category = $categoryRepository->findById($slugModel->reference_id);
        
        if (!$category || $category->status != \Botble\Base\Enums\BaseStatusEnum::PUBLISHED) {
            abort(404);
        }

        $seoMeta = $category->getMetaData('seo_meta', true);
        $description = $seoMeta['seo_description'] ?? '';
        
        if (empty($description)) {
            $desc = str_replace(['<br>', '<br/>', '<br />', '</p>'], ' ', $category->description);
            $desc = strip_tags($desc);
            $desc = preg_replace('/[\x{1F600}-\x{1F64F}\x{1F300}-\x{1F5FF}\x{1F680}-\x{1F6FF}\x{2600}-\x{26FF}\x{2700}-\x{27BF}\x{1F900}-\x{1F9FF}\x{1FA70}-\x{1FAFF}]/u', '', $desc);
            $desc = trim(preg_replace('/\s+/', ' ', $desc));
            $description = \Illuminate\Support\Str::limit($desc, 155);
        }

        \Botble\SeoHelper\Facades\SeoHelper::setTitle($category->name)
            ->setDescription($description);
            
        \Botble\SeoHelper\Facades\SeoHelper::meta()->setUrl(url()->current());
        \Botble\SeoHelper\Facades\SeoHelper::meta()->addMeta('property:og:site_name', theme_option('site_title'));
        
        if ($category->image) {
            \Botble\SeoHelper\Facades\SeoHelper::setImage(RvMedia::getImageUrl($category->image));
        }

        // Poor Man's SSR HTML for Category
        $ssrHtml = '<div class="ssr-category-container" style="padding:20px; max-width:1200px; margin:0 auto; font-family:sans-serif;">';
        $ssrHtml .= '<h1>'.htmlentities($category->name).'</h1>';
        if ($category->description) {
            $ssrHtml .= '<p>'.strip_tags($category->description).'</p>';
        }
        
        // List products in this category
        $products = $category->products()->where('status', \Botble\Base\Enums\BaseStatusEnum::PUBLISHED)->limit(20)->get();
        if ($products->count()) {
            $ssrHtml .= '<ul style="display:grid; grid-template-columns:repeat(auto-fill, minmax(200px, 1fr)); gap:20px; list-style:none; padding:0;">';
            foreach ($products as $prod) {
                $ssrHtml .= '<li style="border:1px solid #eee; padding:10px; border-radius:8px;">';
                $ssrHtml .= '<a href="'.url('product/'.$prod->slug).'" style="text-decoration:none; color:#333;">';
                $ssrHtml .= '<img src="'.RvMedia::getImageUrl($prod->image, 'thumb', false, RvMedia::getDefaultImage()).'" alt="'.htmlentities($prod->name).'" width="200" height="200" style="width:100%; height:auto; aspect-ratio:1;">';
                $ssrHtml .= '<h3 style="font-size:16px; margin:10px 0;">'.htmlentities($prod->name).'</h3>';
                $ssrHtml .= '<div style="color:#d32f2f; font-weight:bold;">'.format_price($prod->front_sale_price ?: $prod->price).'</div>';
                $ssrHtml .= '</a></li>';
            }
            $ssrHtml .= '</ul>';
        }
        $ssrHtml .= '</div>';

        return Theme::scope('page', ['ssrHtml' => $ssrHtml])->render();
    })->name('public.product-category');
});

Theme::routes();
