<template>
  <article class="pcard" tabindex="0" role="link" @click="open" @keydown.enter="open">
    <!-- Media -->
    <div class="pcard-media">
      <img :src="product.image || botbleData?.placeholderImage" :alt="product.name" loading="lazy" />

      <div class="pcard-tags">
        <span v-if="product.is_on_sale" class="tag tag-sale">{{ __('sale') || 'خصم' }}</span>
        <span v-for="label in product.labels || []" :key="label.id" class="tag" :style="{ backgroundColor: label.color }">
          {{ label.name }}
        </span>
      </div>

      <!-- Wishlist is always visible (no hover on touch devices) -->
      <button
        class="pcard-wish"
        :class="{ active: inWishlist }"
        @click.stop="store.toggleWishlist(product)"
        :aria-label="__('wishlist') || 'المفضلة'"
        :aria-pressed="inWishlist"
        type="button"
      >
        <i class="ti" :class="inWishlist ? 'ti-heart-filled' : 'ti-heart'"></i>
      </button>

      <!-- Quick view only makes sense with a pointer; it appears on hover and is hidden on touch -->
      <button class="pcard-qv" @click.stop="store.openQuickView(product.slug)" :aria-label="__('quick_view')" type="button">
        <i class="ti ti-eye"></i> {{ __('quick_view') || 'نظرة سريعة' }}
      </button>
    </div>

    <!-- Body -->
    <div class="pcard-body">
      <h3 class="pcard-name" :title="product.name">{{ product.name }}</h3>

      <div class="pcard-meta">
        <span v-if="product.reviews_count > 0" class="pcard-rating">
          <i class="ti ti-star-filled"></i>
          {{ Number(product.reviews_avg).toFixed(1) }}
          <span class="cnt">({{ product.reviews_count }})</span>
        </span>
        <span v-else class="pcard-rating muted">
          <i class="ti ti-star"></i> {{ __('no_reviews') || 'بدون تقييم' }}
        </span>

        <span class="pcard-stock" :class="stockClass">
          <i></i>{{ stockText }}
        </span>
      </div>

      <div class="pcard-price">
        <span class="now">{{ product.front_sale_price_format || product.price_format || product.price }}</span>
        <span v-if="product.is_on_sale" class="was">{{ product.price_format }}</span>
      </div>

      <div class="pcard-bnpl" v-if="product.accepts_taly || product.accepts_deema">
        <span class="bnpl-text">
          {{ __('pay_in_4') || 'قسطها على 4 دفعات' }}
          <b>{{ installment }}</b> <small>/ {{ __('mo') || 'شهر' }}</small>
        </span>
        <span class="bnpl-brand">{{ product.accepts_taly ? 'TALY' : 'DEEMA' }}</span>
      </div>

      <button class="pcard-add" type="button" @click.stop="addToCart" :disabled="isOut">
        <i class="ti" :class="isOut ? 'ti-circle-x' : (isBackorder ? 'ti-clock' : 'ti-shopping-cart-plus')"></i>
        <span v-if="isOut">{{ __('out_of_stock') || 'غير متوفر' }}</span>
        <span v-else-if="isBackorder">{{ __('pre_order') || 'طلب مسبق' }}</span>
        <span v-else>{{ __('add_to_cart') || 'أضف للسلة' }}</span>
      </button>
    </div>
  </article>
</template>

<script setup>
import { __ } from '../utils/i18n';
import { computed } from 'vue';
import { useRouter } from 'vue-router';
import { useEcommerceStore } from '../stores/ecommerce';

const props = defineProps({
  product: { type: Object, required: true },
});

const store = useEcommerceStore();
const router = useRouter();
const botbleData = window?.BotbleData || {};

const open = () => router.push(`/product/${props.product.slug}`);

const inWishlist = computed(() => !!store.wishlist.find(i => i.id === props.product.id));
const isOut = computed(() => props.product.stock_status === 'out_of_stock');
const isBackorder = computed(() => props.product.stock_status === 'on_backorder');

const stockClass = computed(() => (isOut.value ? 'out' : isBackorder.value ? 'backorder' : 'in'));
const stockText = computed(() =>
  isOut.value ? (__('out_of_stock') || 'نفذت الكمية')
  : isBackorder.value ? (__('pre_order') || 'طلب مسبق')
  : (__('in_stock') || 'متوفر')
);

const installment = computed(() => {
  const base = parseFloat(props.product.front_sale_price || props.product.price || 0);
  return (base / 4).toFixed(3);
});

const addToCart = async () => {
  const success = await store.addToCart(props.product.id, 1);
  if (success) {
    store.notify(__('added_to_cart') || 'تمت الإضافة للسلة بنجاح!', 'success');
  } else {
    store.notify(__('add_to_cart_error') || 'حدث خطأ أثناء الإضافة للسلة.', 'error');
  }
};
</script>

<style scoped>
/* ---- Card shell ---- */
.pcard {
  position: relative;
  display: flex;
  flex-direction: column;
  background: var(--surface);
  border: 1px solid var(--border2, var(--line));
  border-radius: 16px;
  overflow: hidden;
  cursor: pointer;
  outline: none;
  transition: transform .22s ease, box-shadow .22s ease, border-color .2s ease;
}
.pcard:hover,
.pcard:focus-visible {
  transform: translateY(-3px);
  border-color: var(--primary);
  box-shadow: 0 12px 28px -12px rgba(16, 35, 43, .22);
}
.pcard:focus-visible {
  box-shadow: 0 0 0 3px var(--primary-soft, rgba(33, 147, 176, .25));
}

/* ---- Media ---- */
.pcard-media {
  position: relative;
  aspect-ratio: 1 / 1;
  background: var(--surface-2, var(--surface2));
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}
.pcard-media > img {
  width: 100%;
  height: 100%;
  object-fit: contain;
  padding: 14px;
  transition: transform .4s ease;
}
.pcard:hover .pcard-media > img {
  transform: scale(1.05);
}

.pcard-tags {
  position: absolute;
  top: 10px;
  inset-inline-start: 10px;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 5px;
  z-index: 2;
}
.tag {
  display: inline-block;
  font-size: 10.5px;
  font-weight: 800;
  line-height: 1;
  color: #fff;
  padding: 5px 8px;
  border-radius: 999px;
  background: var(--primary-strong);
  letter-spacing: .2px;
}
.tag-sale {
  background: var(--sale, var(--danger));
}

.pcard-wish {
  position: absolute;
  top: 10px;
  inset-inline-end: 10px;
  z-index: 2;
  width: 34px;
  height: 34px;
  border-radius: 50%;
  border: 1px solid var(--border2, var(--line));
  background: var(--surface);
  color: var(--text2, var(--ink-2));
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 17px;
  box-shadow: 0 4px 12px -6px rgba(0, 0, 0, .25);
  transition: color .15s, background .15s, transform .12s;
}
.pcard-wish:hover { color: var(--sale, var(--danger)); }
.pcard-wish:active { transform: scale(.92); }
.pcard-wish.active {
  color: var(--sale, var(--danger));
  border-color: var(--sale, var(--danger));
}

.pcard-qv {
  position: absolute;
  bottom: 10px;
  inset-inline: 10px;
  z-index: 2;
  height: 32px;
  border-radius: 10px;
  border: none;
  background: rgba(16, 35, 43, .82);
  color: #fff;
  font-size: 12px;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  opacity: 0;
  transform: translateY(6px);
  transition: opacity .2s, transform .2s;
  backdrop-filter: blur(4px);
}
.pcard:hover .pcard-qv,
.pcard:focus-within .pcard-qv {
  opacity: 1;
  transform: translateY(0);
}
/* Touch devices have no hover: hide the quick-view overlay entirely */
@media (hover: none) {
  .pcard-qv { display: none; }
}

/* ---- Body ---- */
.pcard-body {
  display: flex;
  flex-direction: column;
  gap: 8px;
  padding: 12px 12px 12px;
  flex: 1;
}

.pcard-name {
  margin: 0;
  font-size: 14px;
  font-weight: 700;
  line-height: 1.45;
  color: var(--text);
  min-height: calc(14px * 1.45 * 2);
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.pcard-meta {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
  font-size: 12px;
}
.pcard-rating {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  font-weight: 700;
  color: var(--text);
}
.pcard-rating .ti { color: var(--stars, #f2a52b); font-size: 13px; }
.pcard-rating .cnt { color: var(--text3, var(--ink-2)); font-weight: 600; }
.pcard-rating.muted { color: var(--text3, var(--ink-2)); font-weight: 600; }
.pcard-rating.muted .ti { color: var(--text3, var(--ink-2)); }

.pcard-stock {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  font-size: 11px;
  font-weight: 700;
  white-space: nowrap;
}
.pcard-stock i {
  width: 7px;
  height: 7px;
  border-radius: 50%;
  display: inline-block;
}
.pcard-stock.in { color: var(--success); }
.pcard-stock.in i { background: var(--success); box-shadow: 0 0 0 3px var(--success-bg, rgba(26, 122, 80, .15)); }
.pcard-stock.out { color: var(--sale, var(--danger)); }
.pcard-stock.out i { background: var(--sale, var(--danger)); box-shadow: 0 0 0 3px rgba(217, 58, 58, .15); }
.pcard-stock.backorder { color: var(--warn); }
.pcard-stock.backorder i { background: var(--warn); box-shadow: 0 0 0 3px rgba(183, 121, 31, .15); }

.pcard-price {
  display: flex;
  align-items: baseline;
  gap: 8px;
  margin-top: 2px;
}
.pcard-price .now {
  font-size: 18px;
  font-weight: 800;
  color: var(--primary-strong);
  letter-spacing: -.2px;
}
.pcard-price .was {
  font-size: 12px;
  color: var(--text3, var(--ink-2));
  text-decoration: line-through;
}

.pcard-bnpl {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
  background: var(--primary-soft, var(--primary-light));
  border-radius: 10px;
  padding: 7px 9px;
}
.bnpl-text {
  font-size: 10.5px;
  color: var(--text2, var(--ink-2));
  font-weight: 700;
  line-height: 1.3;
}
.bnpl-text b { color: var(--text); font-size: 12px; margin-inline-start: 4px; }
.bnpl-text small { color: var(--text3, var(--ink-2)); }
.bnpl-brand {
  font-size: 10px;
  font-weight: 800;
  color: var(--primary-strong);
  background: var(--surface);
  border-radius: 6px;
  padding: 3px 6px;
  letter-spacing: .4px;
}

/* ---- CTA: solid by default (hover-only styling is invisible on phones) ---- */
.pcard-add {
  margin-top: auto;
  width: 100%;
  height: 40px;
  border: none;
  border-radius: 11px;
  background: var(--primary-strong);
  color: var(--on-primary, #fff);
  font-size: 13.5px;
  font-weight: 800;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  transition: filter .15s, transform .12s;
}
.pcard-add .ti { font-size: 17px; }
.pcard-add:hover { filter: brightness(1.08); }
.pcard-add:active { transform: scale(.97); }
.pcard-add:disabled {
  background: var(--surface-2, var(--surface2));
  color: var(--text3, var(--ink-2));
  cursor: not-allowed;
  filter: none;
}
</style>
