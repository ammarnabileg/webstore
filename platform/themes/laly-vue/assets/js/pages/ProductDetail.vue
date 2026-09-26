<template>
  <div class="suha-page">
    <!-- Header -->
    <div class="suha-header">
      <button class="back-btn" @click="$router.back()" :aria-label="__('back')">
        <i class="ti ti-arrow-right" :class="{ 'ti-arrow-left': !botbleData?.is_rtl }"></i>
      </button>
      <div class="header-title">{{ __('product_details') }}</div>
      <button class="cart-btn" @click="$router.push('/cart')" :aria-label="__('cart')">
        <i class="ti ti-shopping-cart"></i>
      </button>
    </div>
    
    <div class="scroll-area">
      <div v-if="store.loading" class="loading-state">
        <div class="spinner"></div>
      </div>
      
      <div v-else-if="product" class="suha-product-wrapper">
        <!-- Desktop Container for flex layout -->
        <div class="desktop-row">
          
          <!-- Product Image Gallery -->
          <div class="suha-image-section">
            <div class="badges" v-if="product.labels?.length">
              <span v-for="label in product.labels" :key="label.id" class="badge" :style="{ backgroundColor: label.color }">{{ label.name }}</span>
            </div>
            
            <div class="main-image">
              <img :src="activeImage || product.image || botbleData?.placeholderImage" :alt="product.name" />
            </div>
            
            <div class="gallery" v-if="allImages.length > 1">
              <div 
                class="thumb" 
                v-for="(img, index) in allImages" 
                :key="index"
                :class="{ active: activeImage === img }"
                @click="activeImage = img"
              >
                <img loading="lazy" :src="img" :alt="product.name + ' thumbnail'" />
              </div>
            </div>
          </div>
          
          <!-- Product Info & Actions -->
          <div class="suha-info-section">
            <div class="title-price-wrap">
              <div class="info-left">
                <h1 class="product-title">{{ product.name }}</h1>
                <div class="product-price">
                  <span class="current-price">{{ view.front_sale_price_format || view.price_format || view.price }}</span>
                  <span class="old-price" v-if="view.is_on_sale">{{ view.price_format }}</span>
                </div>
              </div>
              <button class="wishlist-btn" :class="{'active': store.wishlist.find(i => i.id === product.id)}" @click="store.toggleWishlist(product)">
                <i class="ti ti-heart"></i>
              </button>
            </div>
            
            <!-- BNPL Messaging -->
            <BnplWidgets 
              v-if="product.price || product.front_sale_price"
              :price="product.front_sale_price || product.price"
              :acceptsTaly="product.accepts_taly"
              :acceptsDeema="product.accepts_deema"
            />

            <!-- Variations -->
            <div class="variation-groups" v-if="hasVariations">
              <div class="variation-group" v-for="set in product.variation_info.attribute_sets" :key="set.id">
                <div class="variation-label">
                  {{ set.title }}
                  <span class="variation-chosen" v-if="chosenValueTitle(set)">: {{ chosenValueTitle(set) }}</span>
                </div>
                <div class="variation-values" :class="'layout-' + set.display_layout">
                  <button
                    v-for="val in set.values"
                    :key="val.id"
                    type="button"
                    class="variation-swatch"
                    :class="{
                      selected: selectedAttrs[set.id] === val.id,
                      'is-color': set.display_layout === 'visual' && val.color,
                      unavailable: !isValueAvailable(set.id, val.id)
                    }"
                    :style="(set.display_layout === 'visual' && val.color) ? { backgroundColor: val.color } : null"
                    :title="val.title"
                    :aria-label="val.title"
                    :aria-pressed="selectedAttrs[set.id] === val.id"
                    @click="selectAttr(set.id, val.id)"
                  >
                    <template v-if="set.display_layout === 'visual' && val.color">
                      <i v-if="selectedAttrs[set.id] === val.id" class="ti ti-check"></i>
                    </template>
                    <template v-else>{{ val.title }}</template>
                  </button>
                </div>
              </div>
              <p class="variation-hint" v-if="!activeVariation">{{ __('please_select_options') }}</p>
            </div>

            <!-- Stock & Meta -->
            <div class="product-meta">
              <span class="stock-status" :class="{'in-stock': view.stock_status === 'in_stock' || !view.stock_status, 'out-of-stock': view.stock_status === 'out_of_stock', 'backorder': view.stock_status === 'on_backorder'}">
                <i :class="view.stock_status === 'out_of_stock' ? 'ti ti-x' : (view.stock_status === 'on_backorder' ? 'ti ti-clock' : 'ti ti-check')"></i>
                {{ view.stock_status === 'out_of_stock' ? __('out_of_stock') : (view.stock_status === 'on_backorder' ? __('pre_order') : __('in_stock')) }}
              </span>
              <span class="category" v-if="product.collections?.length">{{ product.collections[0].name }}</span>
            </div>

            <div class="short-desc" v-if="product.description" v-html="product.description"></div>

            <!-- Add to Cart Block -->
            <div class="cart-action-block">
              <div class="qty-selector">
                <button @click="qty > 1 ? qty-- : null"><i class="ti ti-minus"></i></button>
                <input type="number" v-model="qty" min="1" readonly />
                <button @click="qty++" :aria-label="__('increase_qty')"><i class="ti ti-plus"></i></button>
              </div>
              
              <div class="action-buttons">
                <button class="btn-add-cart" @click="addToCart" :disabled="!canAddToCart">
                  <template v-if="hasVariations && !activeVariation">{{ __('please_select_options') }}</template>
                  <template v-else-if="view.stock_status === 'out_of_stock'">{{ __('out_of_stock') }}</template>
                  <template v-else-if="view.stock_status === 'on_backorder'">{{ __('pre_order') }}</template>
                  <template v-else>{{ __('add_to_cart') }}</template>
                </button>
                <button class="btn-buy-now" @click="buyNow" :disabled="!canAddToCart">
                  {{ __('buy_now') }}
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Specifications & Description -->
        <div class="suha-details-section">
          <!-- Quick Specs List -->
          <div class="content-block" v-if="product.attributes && product.attributes.length">
            <h3 class="block-title">{{ __('quick_specs') }}</h3>
            <ul class="specs-list">
              <li v-for="attr in product.attributes" :key="attr.id">
                <i class="ti ti-check text-primary"></i>
                <span class="spec-name">{{ attr.name }}:</span> 
                <span class="spec-val">{{ attr.value }}</span>
              </li>
            </ul>
          </div>

          <!-- Full HTML Content (Overview / Tech Specs Table) -->
          <div class="content-block" v-if="product.content">
            <h3 class="block-title">{{ __('details') }}</h3>
            <div class="html-content" v-html="product.content"></div>
          </div>
          
          <!-- Ratings & Reviews -->
          <div class="content-block" v-if="reviews && reviews.length">
            <h3 class="block-title">{{ __('reviews') || 'التقييمات والمراجعات' }}</h3>
            <div class="reviews-list">
              <div v-for="review in reviews" :key="review.id" class="review-item">
                <div class="review-header">
                  <span class="reviewer-name">{{ review.customer_name || __('customer') }}</span>
                  <div class="review-stars">
                    <i v-for="s in 5" :key="s" class="ti" :class="s <= review.star ? 'ti-star-filled' : 'ti-star'"></i>
                  </div>
                </div>
                <div class="review-comment">{{ review.comment }}</div>
              </div>
            </div>
          </div>

          <!-- Write a review (logged-in customers) -->
          <div class="content-block" v-if="botbleData.customer">
            <h3 class="block-title">{{ __('write_review') }}</h3>
            <div class="review-form">
              <div class="rating-input" :aria-label="__('your_rating')">
                <i
                  v-for="s in 5"
                  :key="s"
                  class="ti"
                  :class="s <= reviewStar ? 'ti-star-filled' : 'ti-star'"
                  role="button"
                  :aria-label="s + ''"
                  @click="reviewStar = s"
                ></i>
              </div>
              <textarea
                v-model="reviewComment"
                rows="3"
                :placeholder="__('review_placeholder')"
                maxlength="1000"
              ></textarea>
              <button class="submit-review-btn" :disabled="submittingReview || !reviewComment.trim()" @click="submitReview">
                {{ submittingReview ? __('loading') : __('submit_review') }}
              </button>
            </div>
          </div>

          <!-- Related Products -->
          <div class="content-block" v-if="relatedProducts && relatedProducts.length">
            <h3 class="block-title">{{ __('related_products') || 'منتجات ذات صلة' }}</h3>
            <div class="related-products-grid">
              <ProductCard v-for="prod in relatedProducts" :key="prod.id" :product="prod" />
            </div>
          </div>
        </div>
        
      </div>

      <div v-else class="empty-state">
        <i class="ti ti-package-off"></i>
        <p>{{ __('product_unavailable') }}</p>
        <button @click="$router.push('/products')" class="btn-primary">{{ __('back_to_products') }}</button>
      </div>
      
      <div style="height: 100px;"></div>
    </div>
  </div>
</template>

<script setup>
import { __ } from '../utils/i18n';
import { ref, onMounted, computed, watch, inject } from 'vue';
import { useRoute } from 'vue-router';
import { useEcommerceStore } from '../stores/ecommerce';
import ProductCard from '../components/ProductCard.vue';
import BnplWidgets from '../components/BnplWidgets.vue';
import api from '../services/api';

const route = useRoute();
const store = useEcommerceStore();
const botbleData = window?.BotbleData || {};

const qty = ref(1);
const product = computed(() => store.currentProduct);
const activeImage = ref('');
const relatedProducts = ref([]);
const reviews = ref([]);

// Write-a-review form state.
const reviewStar = ref(5);
const reviewComment = ref('');
const submittingReview = ref(false);

// --- Variations ---
// selectedAttrs maps an attribute-set id -> the chosen attribute (value) id.
const selectedAttrs = ref({});

const hasVariations = computed(() => !!(product.value?.has_variations && product.value?.variation_info?.attribute_sets?.length));

// A variation whose attribute_ids exactly match the current selection across every set.
const activeVariation = computed(() => {
    if (!hasVariations.value) return null;
    const sets = product.value.variation_info.attribute_sets;
    if (sets.some(set => !selectedAttrs.value[set.id])) return null; // incomplete selection
    const chosen = sets.map(set => selectedAttrs.value[set.id]).sort((a, b) => a - b);
    return product.value.variation_info.variations.find(v => {
        const ids = [...v.attribute_ids].sort((a, b) => a - b);
        return ids.length === chosen.length && ids.every((id, i) => id === chosen[i]);
    }) || null;
});

// The pricing/stock/image source the template binds to: the picked variation, else the parent product.
const view = computed(() => activeVariation.value || product.value || {});

const canAddToCart = computed(() => {
    if (!product.value) return false;
    if (hasVariations.value) return !!activeVariation.value && !activeVariation.value.is_out_of_stock;
    return view.value.stock_status !== 'out_of_stock';
});

const initVariations = () => {
    selectedAttrs.value = {};
    if (!hasVariations.value) return;
    const info = product.value.variation_info;
    // Map each attribute (value) id to the set it belongs to, then preselect the defaults.
    const attrToSet = {};
    info.attribute_sets.forEach(set => set.values.forEach(v => { attrToSet[v.id] = set.id; }));
    (info.default_attribute_ids || []).forEach(attrId => {
        const setId = attrToSet[attrId];
        if (setId) selectedAttrs.value[setId] = attrId;
    });
};

const selectAttr = (setId, valId) => {
    selectedAttrs.value = { ...selectedAttrs.value, [setId]: valId };
};

const chosenValueTitle = (set) => {
    const id = selectedAttrs.value[set.id];
    const val = set.values.find(v => v.id === id);
    return val ? val.title : '';
};

// A value is available if, combined with the current selections in the OTHER sets,
// at least one variation exists.
const isValueAvailable = (setId, valId) => {
    if (!hasVariations.value) return true;
    const info = product.value.variation_info;
    const otherSelected = Object.entries(selectedAttrs.value)
        .filter(([sid]) => Number(sid) !== Number(setId))
        .map(([, aid]) => aid);
    return info.variations.some(v =>
        v.attribute_ids.includes(valId) && otherSelected.every(aid => v.attribute_ids.includes(aid))
    );
};

// Swap the main image to the selected variation's image when it has one.
watch(activeVariation, (v) => {
    if (v && v.image) activeImage.value = v.image;
});

const allImages = computed(() => {
    if (!product.value) return [];
    let images = [];
    if (product.value.image) images.push(product.value.image);
    if (product.value.images && product.value.images.length > 0) {
        images = [...images, ...product.value.images.filter(img => img !== product.value.image)];
    }
    return images;
});

onMounted(() => {
    fetchProduct();
});

watch(() => route.params.slug, (newSlug) => {
    if (newSlug) fetchProduct();
});

const fetchExtras = async (slug) => {
    try {
        // allSettled: one failing request must not hide the other section.
        const [relatedRes, reviewsRes] = await Promise.allSettled([
            api.get(`/products/${slug}/related`),
            api.get(`/products/${slug}/reviews`)
        ]);
        relatedProducts.value = relatedRes.status === 'fulfilled' ? (relatedRes.value.data?.data || []) : [];
        reviews.value = reviewsRes.status === 'fulfilled' ? (reviewsRes.value.data?.data || []) : [];
    } catch (e) {
        console.error('Error fetching extras:', e);
    }
};

const fetchProduct = () => {
    if (route.params.slug) {
        store.fetchProductBySlug(route.params.slug).then(() => {
            activeImage.value = store.currentProduct?.image || '';
            initVariations();

            const SITE_NAME = window.BotbleData?.site_title || 'Laly Kuwait';
            if (store.currentProduct?.name) {
                document.title = `${store.currentProduct.name} - ${SITE_NAME}`;
            }
            
            fetchExtras(route.params.slug);
        });
        qty.value = 1;
    }
};

// For a variable product the variation's own product id is what the cart expects.
const cartProductId = () => (activeVariation.value ? activeVariation.value.id : product.value?.id);

const addToCart = async () => {
    if (!product.value) return;
    if (hasVariations.value && !activeVariation.value) {
        store.notify(__('please_select_options') || 'يرجى اختيار الخيارات.', 'error');
        return;
    }
    const success = await store.addToCart(cartProductId(), qty.value);
    if (success) {
        store.notify(__('added_to_cart') || 'تمت الإضافة للسلة بنجاح!', 'success');
    } else {
        store.notify(__('add_to_cart_error') || 'حدث خطأ.', 'error');
    }
};

const buyNow = async () => {
    if (!product.value) return;
    if (hasVariations.value && !activeVariation.value) {
        store.notify(__('please_select_options') || 'يرجى اختيار الخيارات.', 'error');
        return;
    }
    const success = await store.addToCart(cartProductId(), qty.value);
    if (success) {
        window.location.href = botbleData?.checkoutUrl || '/checkout';
    } else {
        store.notify(__('add_to_cart_error') || 'حدث خطأ.', 'error');
    }
};

const submitReview = async () => {
    if (!product.value || !reviewComment.value.trim()) return;
    submittingReview.value = true;
    try {
        const res = await store.submitReview({
            product_id: product.value.id,
            star: reviewStar.value,
            comment: reviewComment.value.trim(),
        });
        if (res.ok) {
            store.notify(res.message || __('review_submitted'), 'success');
            reviewComment.value = '';
            reviewStar.value = 5;
            fetchExtras(route.params.slug); // refresh the list (or show pending-approval note)
        } else {
            store.notify(res.message || __('review_error'), 'error');
        }
    } finally {
        submittingReview.value = false;
    }
};
</script>

<style scoped>
/* Write a review */
.review-form {
  display: flex;
  flex-direction: column;
  gap: 12px;
}
.rating-input {
  display: flex;
  gap: 6px;
  font-size: 26px;
  color: var(--stars, #f2a52b);
  cursor: pointer;
}
.rating-input .ti {
  cursor: pointer;
}
.review-form textarea {
  width: 100%;
  padding: 12px;
  border-radius: 10px;
  border: 1px solid var(--line);
  background: var(--surface);
  color: var(--text);
  font-family: inherit;
  font-size: 14px;
  resize: vertical;
}
.submit-review-btn {
  align-self: flex-start;
  padding: 10px 20px;
  border-radius: 10px;
  border: none;
  background: var(--primary-strong);
  color: var(--on-primary);
  font-weight: 700;
  cursor: pointer;
}
.submit-review-btn:disabled {
  opacity: .6;
  cursor: default;
}

/* Variations */
.variation-groups {
  margin: 16px 0;
  display: flex;
  flex-direction: column;
  gap: 14px;
}
.variation-label {
  font-weight: 600;
  font-size: 14px;
  color: var(--text);
  margin-bottom: 8px;
}
.variation-chosen {
  color: var(--text2);
  font-weight: 500;
}
.variation-values {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}
.variation-swatch {
  min-width: 44px;
  min-height: 44px;
  padding: 8px 14px;
  border: 1px solid var(--border2, var(--line));
  border-radius: 10px;
  background: var(--surface);
  color: var(--text);
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  transition: border-color .15s, box-shadow .15s;
}
.variation-swatch.is-color {
  width: 40px;
  height: 40px;
  padding: 0;
  border-radius: 50%;
  color: #fff;
  font-size: 16px;
}
.variation-swatch.selected {
  border-color: var(--primary);
  box-shadow: 0 0 0 2px var(--primary);
}
.variation-swatch.unavailable {
  opacity: .4;
  text-decoration: line-through;
}
.variation-swatch.is-color.unavailable {
  text-decoration: none;
}
.variation-hint {
  color: var(--sale, #d93a3a);
  font-size: 13px;
  font-weight: 600;
  margin: 4px 0 0;
}

/* Base Styles */
.suha-page {
  background-color: var(--surface);
  min-height: 100vh;
  font-family: inherit;
  color: var(--text);
}
.scroll-area {
  padding-top: 60px; /* Space for fixed header on mobile */
}

/* Header (Mobile style) */
.suha-header {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  height: 60px;
  background: var(--bg);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 15px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.05);
  z-index: 1000;
}
[data-theme="dark"] .suha-header {
  box-shadow: 0 2px 10px rgba(0,0,0,0.3);
}
.header-title {
  font-weight: 700;
  font-size: 16px;
  color: var(--text);
}
.suha-header button {
  background: none;
  border: none;
  font-size: 20px;
  color: var(--text);
  cursor: pointer;
  padding: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Common Layout */
.suha-product-wrapper {
  max-width: 1200px;
  margin: 0 auto;
}

/* Sections */
.suha-image-section {
  background: var(--bg);
  position: relative;
  text-align: center;
  padding: 20px;
  border-bottom-left-radius: 20px;
  border-bottom-right-radius: 20px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.03);
  margin-bottom: 15px;
}
.badges {
  position: absolute;
  top: 20px;
  inset-inline-start: 20px;
  display: flex;
  flex-direction: column;
  gap: 5px;
  z-index: 2;
}
.badge {
  color: #fff;
  padding: 4px 10px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 600;
}

.main-image {
  height: 320px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.main-image img {
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
}
.gallery {
  display: flex;
  gap: 10px;
  overflow-x: auto;
  justify-content: center;
  padding: 15px 0 5px;
}
.thumb {
  width: 60px;
  height: 60px;
  border: 2px solid transparent;
  border-radius: 10px;
  padding: 5px;
  cursor: pointer;
  background: var(--surface);
  flex-shrink: 0;
}
.thumb.active {
  border-color: var(--primary);
}
.thumb img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.suha-info-section {
  background: var(--bg);
  padding: 25px 20px;
  border-radius: 20px;
  margin-bottom: 15px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.03);
}

.title-price-wrap {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 15px;
}
.info-left {
  flex: 1;
  padding-left: 15px; /* RTL padding */
}
html[dir="ltr"] .info-left { padding-left: 0; padding-right: 15px; }

.product-title {
  font-size: 20px;
  font-weight: 700;
  line-height: 1.4;
  margin: 0 0 10px 0;
  color: var(--text);
}
.product-price {
  display: flex;
  align-items: center;
  gap: 10px;
}
.current-price {
  font-size: 22px;
  font-weight: 800;
  color: var(--primary);
}
.old-price {
  font-size: 14px;
  color: var(--text3);
  text-decoration: line-through;
}
.wishlist-btn {
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background: var(--surface);
  border: none;
  color: var(--text3);
  font-size: 22px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
}
.wishlist-btn.active, .wishlist-btn:hover {
  background: var(--primary-strong);
  color: var(--on-primary);
}

.product-meta {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-bottom: 20px;
  font-size: 13px;
  font-weight: 600;
}
.stock-status {
  color: var(--primary);
}
.stock-status.in-stock {
  color: var(--primary);
}
.category {
  color: var(--primary);
  background: var(--primary-light);
  padding: 4px 10px;
  border-radius: 20px;
}

.short-desc {
  color: var(--text3);
  font-size: 14px;
  line-height: 1.6;
  margin-bottom: 25px;
}

/* Add to Cart Actions */
.cart-action-block {
  display: flex;
  flex-direction: column;
  gap: 15px;
}
.qty-selector {
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: var(--surface);
  border-radius: 8px;
  padding: 5px;
  width: 140px;
}
.qty-selector button {
  width: 40px;
  height: 40px;
  background: var(--bg);
  border: none;
  border-radius: 6px;
  color: var(--text);
  font-size: 16px;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(0,0,0,0.05);
}
[data-theme="dark"] .qty-selector button {
  background: rgba(255,255,255,0.1);
}
.qty-selector input {
  width: 40px;
  text-align: center;
  border: none;
  background: transparent;
  font-weight: 700;
  font-size: 16px;
  color: var(--text);
}
.action-buttons {
  display: flex;
  gap: 10px;
}
.btn-add-cart, .btn-buy-now {
  flex: 1;
  padding: 15px;
  border-radius: 8px;
  font-size: 15px;
  font-weight: 700;
  border: none;
  cursor: pointer;
  transition: all 0.3s;
}
.btn-add-cart {
  background: var(--primary-strong);
  color: var(--on-primary);
}
.btn-buy-now {
  background: var(--primary-dark); /* slightly darker shade of primary */
  color: #fff;
}
.btn-add-cart:disabled, .btn-buy-now:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* Specifications / Details */
.suha-details-section {
  padding: 0 10px;
}
.content-block {
  background: var(--bg);
  padding: 25px 20px;
  border-radius: 20px;
  margin-bottom: 15px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.03);
}
.block-title {
  font-size: 16px;
  font-weight: 700;
  color: var(--text);
  margin: 0 0 20px 0;
  padding-bottom: 10px;
  border-bottom: 1px solid var(--border);
}

/* Specs List (Suha style) */
.specs-list {
  list-style: none;
  padding: 0;
  margin: 0;
}
.specs-list li {
  display: flex;
  align-items: flex-start;
  gap: 10px;
  margin-bottom: 12px;
  font-size: 14px;
  line-height: 1.5;
}
.text-primary {
  color: var(--primary);
  margin-top: 3px;
}
.spec-name {
  font-weight: 700;
  color: var(--text);
}
.spec-val {
  color: var(--text3);
}

/* User HTML Table Fixes for Light Theme */
.html-content {
  font-size: 14px;
  color: var(--text3);
  line-height: 1.7;
}

:deep(.html-content pre), :deep(.html-content code) {
  background: transparent !important;
  border: none !important;
  padding: 0 !important;
  margin: 0 !important;
  font-family: inherit !important;
  white-space: normal !important;
  box-shadow: none !important;
}

:deep(.html-content table.specs-table) {
  width: 100%;
  border-collapse: collapse;
  margin: 15px 0;
  background: var(--bg);
  border-radius: 8px;
  overflow: hidden;
  border: 1px solid var(--border);
}
:deep(.html-content table.specs-table th), :deep(.html-content table.specs-table td) {
  padding: 12px 15px;
  border-bottom: 1px solid var(--border);
  text-align: start;
  color: var(--text3);
}
:deep(.html-content table.specs-table tr.section-header th) {
  background: var(--primary-light);
  color: var(--primary);
  font-size: 14px;
  font-weight: 700;
}
:deep(.html-content table.specs-table td.spec-label) {
  font-weight: 700;
  color: var(--text);
  width: 35%;
  background: var(--primary-light);
}
:deep(.html-content table.specs-table td.spec-value) {
  color: var(--text3);
}

/* Mobile Responsive Table */
@media (max-width: 767px) {
  :deep(.html-content table.specs-table),
  :deep(.html-content table.specs-table tbody),
  :deep(.html-content table.specs-table tr),
  :deep(.html-content table.specs-table th),
  :deep(.html-content table.specs-table td) {
    display: block;
    width: 100%;
    text-align: start;
  }
  :deep(.html-content table.specs-table tr) {
    margin-bottom: 10px;
    border: 1px solid var(--border);
    border-radius: 6px;
  }
  :deep(.html-content table.specs-table td.spec-label) {
    background: var(--primary-light);
    border-bottom: none;
    padding: 10px 15px;
  }
  :deep(.html-content table.specs-table td.spec-value) {
    padding: 5px 15px 15px 15px;
    border-bottom: none;
  }
  :deep(.html-content table.specs-table tr.section-header th) {
    text-align: center;
  }
}

.empty-state {
  text-align: center;
  padding: 80px 20px;
}
.empty-state i {
  font-size: 60px;
  color: var(--text3);
  margin-bottom: 20px;
  display: block;
}
.btn-primary {
  background: var(--primary-strong);
  color: var(--on-primary);
  border: none;
  padding: 12px 25px;
  border-radius: 8px;
  font-weight: 700;
  margin-top: 20px;
  cursor: pointer;
}

/* Desktop layout optimizations */
@media (min-width: 768px) {
  .suha-page {
    padding-top: 40px;
  }
  .suha-header {
    display: none;
  }
  .scroll-area {
    padding-top: 0;
  }
  .desktop-row {
    display: flex;
    gap: 30px;
    margin-bottom: 30px;
    padding: 0 15px;
    align-items: flex-start; /* Prevent stretching columns to match height */
  }
  .suha-image-section {
    flex: 0 0 calc(45% - 15px);
    width: calc(45% - 15px);
    margin-bottom: 0;
    border-radius: 20px;
    border: 1px solid var(--border);
  }
  .main-image {
    height: 450px;
    padding: 20px;
  }
  .suha-info-section {
    flex: 0 0 calc(55% - 15px);
    width: calc(55% - 15px);
    margin-bottom: 0;
    border: 1px solid var(--border);
  }
  .suha-details-section {
    padding: 0 15px;
  }
  .content-block {
    border: 1px solid var(--border);
  }
  .cart-action-block {
    flex-direction: row;
    align-items: center;
    max-width: 600px;
  }
  .qty-selector {
    padding: 8px;
    width: 150px;
  }
  .action-buttons {
    flex: 1;
    display: flex;
    gap: 15px;
  }
}

/* Reviews */
.reviews-list {
  display: flex;
  flex-direction: column;
  gap: 15px;
}
.review-item {
  padding-bottom: 15px;
  border-bottom: 1px solid var(--border);
}
.review-item:last-child {
  border-bottom: none;
  padding-bottom: 0;
}
.review-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 8px;
}
.reviewer-name {
  font-weight: 700;
  color: var(--text);
  font-size: 14px;
}
.review-stars i {
  color: #ffb800;
  font-size: 13px;
}
.review-stars i.ti-star {
  color: var(--border);
}
.review-comment {
  color: var(--text3);
  font-size: 13px;
  line-height: 1.6;
}

/* Related Products */
.related-products-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 15px;
}
@media (min-width: 768px) {
  .related-products-grid {
    grid-template-columns: repeat(4, 1fr);
  }
}
</style>
