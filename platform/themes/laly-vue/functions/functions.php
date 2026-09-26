<?php

register_page_template([
    'default' => 'Default',
]);



require_once __DIR__ . '/bnpl-meta-boxes.php';

add_filter('theme_option_field_is_shared', function ($isShared, $key) {
    $translatable = [
        'logo', 'favicon', 'site_title', 'seo_title', 'seo_description', 'seo_og_image',
    ];
    if (in_array($key, $translatable)) {
        return false;
    }
    return $isShared;
}, 120, 2);

app()->booted(function () {
    if (class_exists(\Botble\SeoHelper\Forms\SeoForm::class)) {
        \Botble\SeoHelper\Forms\SeoForm::extend(function (\Botble\SeoHelper\Forms\SeoForm $form) {
            $html = '
                <div class="form-group mb-3 ai-seo-generator-wrapper" style="background: #f8f9fa; padding: 15px; border-radius: 8px; border: 1px dashed #ced4da;">
                    <label class="control-label">✨ توليد SEO (Qwen AI)</label>
                    <p class="text-muted small">قم بتوليد عنوان ووصف SEO احترافي ومحسن للمبيعات بضغطة زر باستخدام الذكاء الاصطناعي.</p>
                    <div class="input-group">
                        <input type="text" id="ai_seo_source_url" class="form-control" placeholder="رابط الشركة المصنعة (اختياري لجلب مواصفات أدق)">
                        <button type="button" class="btn btn-primary" id="btn-generate-ai-seo">
                            <i class="ti ti-wand"></i> توليد الآن
                        </button>
                    </div>
                    <div id="ai-seo-error-msg" class="text-danger mt-2" style="display:none; font-size: 0.9em;"></div>
                </div>
                <script>
                    document.addEventListener("DOMContentLoaded", function() {
                        const btn = document.getElementById("btn-generate-ai-seo");
                        if (!btn) return;
                        
                        btn.addEventListener("click", function() {
                            let productId = null;
                            const urlParts = window.location.pathname.split("/");
                            const lastPart = urlParts[urlParts.length - 1];
                            if (!isNaN(parseInt(lastPart)) && isFinite(lastPart)) {
                                productId = lastPart;
                            } else {
                                const idInput = document.querySelector("input[name=\'id\']");
                                if (idInput) productId = idInput.value;
                            }
                            
                            if (!productId) {
                                alert("يجب حفظ المنتج مرة واحدة على الأقل قبل توليد الـ SEO.");
                                return;
                            }
                            const sourceUrl = document.getElementById("ai_seo_source_url").value;
                            
                            const csrfToken = document.querySelector("meta[name=\'csrf-token\']").getAttribute("content");
                            
                            btn.disabled = true;
                            btn.innerHTML = "<i class=\'ti ti-loader ti-spin\'></i> ⏳ جاري التوليد بدقة...";
                            document.getElementById("ai-seo-error-msg").style.display = "none";
                            
                            fetch("'.route('ecommerce.products.generate-seo').'", {
                                method: "POST",
                                headers: {
                                    "Content-Type": "application/json",
                                    "X-CSRF-TOKEN": csrfToken,
                                    "Accept": "application/json"
                                },
                                body: JSON.stringify({
                                    product_id: productId,
                                    source_url: sourceUrl
                                })
                            })
                            .then(response => {
                                if (!response.ok) {
                                    return response.json().then(err => { throw err; });
                                }
                                return response.json();
                            })
                            .then(data => {
                                if (data.seo_title) {
                                    const titleInput = document.querySelector("input[name=\'seo_meta[seo_title]\']");
                                    if (titleInput) {
                                        titleInput.value = data.seo_title;
                                        titleInput.dispatchEvent(new Event("keyup"));
                                    }
                                }
                                if (data.seo_description) {
                                    const descInput = document.querySelector("textarea[name=\'seo_meta[seo_description]\']");
                                    if (descInput) {
                                        descInput.value = data.seo_description;
                                        descInput.dispatchEvent(new Event("keyup"));
                                    }
                                }
                                btn.disabled = false;
                                btn.innerHTML = "<i class=\'ti ti-check\'></i> تم التوليد بنجاح";
                                setTimeout(() => {
                                    btn.innerHTML = "<i class=\'ti ti-wand\'></i> توليد الآن";
                                }, 3000);
                            })
                            .catch(error => {
                                console.error(error);
                                btn.disabled = false;
                                btn.innerHTML = "<i class=\'ti ti-wand\'></i> حاول مرة أخرى";
                                const errorDiv = document.getElementById("ai-seo-error-msg");
                                errorDiv.innerText = error.message || "حدث خطأ غير متوقع";
                                errorDiv.style.display = "block";
                            });
                        });
                    });
                </script>
            ';

            $form->addAfter('seo_meta[seo_description]', 'generate_ai_seo', 'html', [
                'html' => $html
            ]);
        });
    }

    if (class_exists(\Botble\Ecommerce\Forms\ProductForm::class)) {
        \Botble\Ecommerce\Forms\ProductForm::extend(function (\Botble\Ecommerce\Forms\ProductForm $form) {
            $html = '
                <div class="form-group mb-3 ai-specs-generator-wrapper" style="background: #eef2f5; padding: 15px; border-radius: 8px; border: 1px dashed #ced4da; margin-top: 15px;">
                    <label class="control-label">✨ استخراج المواصفات بالـ AI (Qwen)</label>
                    <p class="text-muted small">قم بتحليل رابط الشركة المصنعة واستخراج جدول مواصفات فنية منظم ليتم إدراجه في الوصف مباشرة.</p>
                    <div class="input-group">
                        <input type="text" id="ai_specs_source_url" class="form-control" placeholder="رابط الشركة المصنعة (TP-Link, Samsung, etc...)">
                        <button type="button" class="btn btn-success" id="btn-generate-ai-specs">
                            <i class="ti ti-wand"></i> استخراج وإدراج
                        </button>
                    </div>
                    <div id="ai-specs-error-msg" class="text-danger mt-2" style="display:none; font-size: 0.9em;"></div>
                </div>
                <script>
                    document.addEventListener("DOMContentLoaded", function() {
                        const btn = document.getElementById("btn-generate-ai-specs");
                        if (!btn) return;
                        
                        btn.addEventListener("click", function() {
                            const sourceUrl = document.getElementById("ai_specs_source_url").value;
                            let existingDescription = "";
                            
                            // Try to get content from TinyMCE if it exists, otherwise from textarea
                            if (typeof tinymce !== "undefined" && tinymce.get("content")) {
                                existingDescription = tinymce.get("content").getContent();
                            } else {
                                const contentTextarea = document.getElementById("content");
                                if (contentTextarea) {
                                    existingDescription = contentTextarea.value;
                                }
                            }
                            
                            if (!sourceUrl && existingDescription.replace(/(<([^>]+)>)/ig, "").trim().length < 50) {
                                alert("يجب وضع رابط الشركة المصنعة أو كتابة وصف مبدئي للمنتج ليستخرج الذكاء الاصطناعي منه المواصفات.");
                                return;
                            }
                            
                            const csrfToken = document.querySelector("meta[name=\'csrf-token\']").getAttribute("content");
                            
                            btn.disabled = true;
                            btn.innerHTML = "<i class=\'ti ti-loader ti-spin\'></i> ⏳ جاري التحليل والاستخراج...";
                            document.getElementById("ai-specs-error-msg").style.display = "none";
                            
                            fetch("'.route('ecommerce.products.generate-specs').'", {
                                method: "POST",
                                headers: {
                                    "Content-Type": "application/json",
                                    "X-CSRF-TOKEN": csrfToken,
                                    "Accept": "application/json"
                                },
                                body: JSON.stringify({
                                    source_url: sourceUrl,
                                    existing_description: existingDescription
                                })
                            })
                            .then(response => {
                                if (!response.ok) {
                                    return response.json().then(err => { throw err; });
                                }
                                return response.json();
                            })
                            .then(data => {
                                if (data.data && data.data.specs_html) {
                                    const specsHtml = "<br><h4>المواصفات الفنية</h4>" + data.data.specs_html;
                                    let applied = false;
                                    
                                    // 1. TinyMCE
                                    if (typeof tinymce !== "undefined" && tinymce.get("content")) {
                                        tinymce.get("content").execCommand("mceInsertContent", false, specsHtml);
                                        applied = true;
                                    } 
                                    // 2. CKEditor 4
                                    else if (typeof window.CKEDITOR !== "undefined" && window.CKEDITOR.instances["content"]) {
                                        const editor = window.CKEDITOR.instances["content"];
                                        editor.insertHtml(specsHtml);
                                        applied = true;
                                    }
                                    
                                    const target = document.getElementById("content");
                                    if (target && !applied) {
                                        // 3. CKEditor 5 Attached Instance (Botble standard)
                                        if (target.ckeditorInstance) {
                                            const currentData = target.ckeditorInstance.getData();
                                            target.ckeditorInstance.setData(currentData + "<br><br>" + specsHtml);
                                            applied = true;
                                        }
                                        // 4. Direct DOM Injection for CKEditor 5 (fallback)
                                        if (!applied) {
                                            const ckContainer = target.nextElementSibling;
                                            if (ckContainer && ckContainer.classList.contains("ck-editor")) {
                                                const editable = ckContainer.querySelector(".ck-content");
                                                if (editable) {
                                                    editable.innerHTML += "<br><br>" + specsHtml;
                                                    applied = true;
                                                    // trigger input event so ckeditor detects it
                                                    editable.dispatchEvent(new Event("input", { bubbles: true }));
                                                }
                                            }
                                        }
                                        // 5. Standard Textarea Fallback
                                        if (!applied) {
                                            target.value += "\\n\\n" + specsHtml;
                                        }
                                    }
                                }
                                btn.disabled = false;
                                btn.innerHTML = "<i class=\'ti ti-check\'></i> تم الإدراج بنجاح";
                                setTimeout(() => {
                                    btn.innerHTML = "<i class=\'ti ti-wand\'></i> استخراج وإدراج";
                                }, 3000);
                            })
                            .catch(error => {
                                console.error(error);
                                btn.disabled = false;
                                btn.innerHTML = "<i class=\'ti ti-wand\'></i> حاول مرة أخرى";
                                const errorDiv = document.getElementById("ai-specs-error-msg");
                                errorDiv.innerText = error.error || error.message || "حدث خطأ غير متوقع";
                                errorDiv.style.display = "block";
                            });
                        });
                    });
                </script>
            ';

            $form->addAfter('content', 'generate_ai_specs', 'html', [
                'html' => $html
            ]);
        });
    }
});

add_filter('social_login_providers', function ($providers) {
    $providers['apple'] = [
        'data' => [
            'app_id',
            'app_secret',
        ],
        'disable' => [
            'app_secret',
        ],
    ];
    return $providers;
}, 120);


if (! function_exists('laly_vue_product_card')) {
    /**
     * Product fields shared by every storefront list (listing, search, home sections).
     * Sale/stock/rating flags are computed here so the Vue cards never have to guess.
     */
    function laly_vue_product_card($product): array
    {
        $price = (float) $product->price;
        // front_sale_price runs the whole price pipeline (sales, flash sales, discounts) on every read.
        $salePrice = $product->front_sale_price;
        $finalPrice = (float) $salePrice;
        $isOutOfStock = method_exists($product, 'isOutOfStock') ? $product->isOutOfStock() : false;

        return [
            'id' => $product->id,
            'name' => html_entity_decode($product->name),
            'slug' => $product->slug,
            'image' => RvMedia::getImageUrl($product->image, 'medium', false, RvMedia::getDefaultImage()),
            'price' => $product->price,
            'price_format' => format_price($product->price),
            'front_sale_price' => $salePrice,
            'front_sale_price_format' => format_price($salePrice),
            // front_sale_price is always the final price; it is a discount only when lower than price.
            'is_on_sale' => $finalPrice > 0 && $finalPrice < $price,
            'is_out_of_stock' => $isOutOfStock,
            'stock_status' => $isOutOfStock ? 'out_of_stock' : (string) $product->stock_status,
            'reviews_avg' => round((float) $product->reviews_avg, 1),
            'reviews_count' => (int) $product->reviews_count,
            'labels' => $product->productLabels
                ? $product->productLabels->map(fn ($label) => ['id' => $label->id, 'name' => $label->name, 'color' => $label->color])
                : [],
            'accepts_taly' => $product->getMetaData('accepts_taly', true) == 1,
            'accepts_deema' => $product->getMetaData('accepts_deema', true) == 1,
        ];
    }
}

if (! function_exists('laly_vue_variation_info')) {
    /**
     * Variation data for a configurable (parent) product, shaped for the Vue SPA.
     *
     * Returns the attribute swatch groups (only values actually used by this
     * product's published variations), the full per-variation map so the client
     * can resolve a swatch selection to a variation without a round-trip, and the
     * default variation's attribute ids for the initial selection. Returns null
     * for simple products (no variations) and for variation children themselves.
     */
    function laly_vue_variation_info($product): ?array
    {
        $product->loadMissing([
            'variations.product',
            'variations.productAttributes.productAttributeSet',
            'defaultVariation.productAttributes',
        ]);

        if ($product->is_variation || $product->variations->isEmpty()) {
            return null;
        }

        $usedAttributeIds = [];
        $variationsOut = [];

        foreach ($product->variations as $variation) {
            $variationProduct = $variation->product;
            if (! $variationProduct || $variationProduct->status != \Botble\Base\Enums\BaseStatusEnum::PUBLISHED) {
                continue;
            }

            $attrIds = $variation->productAttributes
                ->pluck('id')
                ->map(fn ($id) => (int) $id)
                ->values()
                ->all();

            foreach ($attrIds as $attrId) {
                $usedAttributeIds[$attrId] = true;
            }

            $card = laly_vue_product_card($variationProduct);

            $variationsOut[] = [
                'id' => $variationProduct->id,
                'attribute_ids' => $attrIds,
                'price' => $card['price'],
                'price_format' => $card['price_format'],
                'front_sale_price' => $card['front_sale_price'],
                'front_sale_price_format' => $card['front_sale_price_format'],
                'is_on_sale' => $card['is_on_sale'],
                'is_out_of_stock' => $card['is_out_of_stock'],
                'stock_status' => $card['stock_status'],
                'image' => $card['image'],
                'sku' => $variationProduct->sku,
            ];
        }

        if (empty($variationsOut)) {
            return null;
        }

        $sets = [];
        foreach (\Botble\Ecommerce\Models\ProductAttributeSet::getByProductId($product->id) as $set) {
            $values = [];
            foreach ($set->attributes as $attribute) {
                if (! isset($usedAttributeIds[$attribute->id])) {
                    continue;
                }
                $values[] = [
                    'id' => (int) $attribute->id,
                    'title' => $attribute->title,
                    'slug' => $attribute->slug,
                    'color' => $attribute->color,
                    'is_default' => (bool) $attribute->is_default,
                ];
            }
            if (! empty($values)) {
                $sets[] = [
                    'id' => (int) $set->id,
                    'title' => $set->title,
                    'slug' => $set->slug,
                    'display_layout' => $set->display_layout,
                    'values' => $values,
                ];
            }
        }

        if (empty($sets)) {
            return null;
        }

        $defaultAttributeIds = $product->defaultVariation
            ? $product->defaultVariation->productAttributes
                ->pluck('id')
                ->map(fn ($id) => (int) $id)
                ->values()
                ->all()
            : [];

        return [
            'attribute_sets' => $sets,
            'variations' => $variationsOut,
            'default_attribute_ids' => $defaultAttributeIds,
        ];
    }
}
