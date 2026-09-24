<template>
  <div class="pcard card" tabindex="0" @click="$router.push(`/product/${product.slug}`)">
    <div class="part">
      <div class="pbadges" v-if="product.labels?.length">
        <span v-for="label in product.labels" :key="label.id" class="chipb new" :style="{ backgroundColor: label.color }">
          <i class="ti ti-tag" style="font-size:12px;"></i> {{ label.name }}
        </span>
      </div>
      <span v-if="product.is_on_sale" class="off">{{ __('sale') || 'خصم' }}</span>
      <img :src="product.image || botbleData?.placeholderImage" :alt="product.name" loading="lazy" />
      
      <!-- Wishlist / Quickview floating actions -->
      <div class="pcard-actions">
        <button class="action-btn" @click.stop="store.toggleWishlist(product)" :class="{'active': store.wishlist.find(i => i.id === product.id)}" :title="__('wishlist') || 'المفضلة'">
          <i class="ti ti-heart"></i>
        </button>
        <button class="action-btn" @click.stop="store.openQuickView(product.slug)" :title="__('quick_view') || 'نظرة سريعة'" :aria-label="__('quick_view')">
          <i class="ti ti-eye"></i>
        </button>
      </div>
    </div>
    
    <div class="rrow">
      <template v-if="product.reviews_count > 0">
        <span class="stars"><i class="ti ti-star-filled" style="font-size:13px; color:var(--stars);"></i></span>
        <b>{{ Number(product.reviews_avg).toFixed(1) }}</b>
        <span class="rc">({{ product.reviews_count }})</span>
      </template>
      
      <span v-if="product.stock_status === 'out_of_stock'" class="stk" style="color:var(--danger)">
        <i style="background:var(--danger);box-shadow:0 0 0 3px rgba(239, 68, 68, 0.2)"></i>{{ __('out_of_stock') || 'نفذت الكمية' }}
      </span>
      <span v-else-if="product.stock_status === 'on_backorder'" class="stk" style="color:var(--warn)">
        <i style="background:var(--warn);box-shadow:0 0 0 3px rgba(245, 158, 11, 0.2)"></i>{{ __('pre_order') || 'طلب مسبق' }}
      </span>
      <span v-else class="stk">
        <i></i>{{ __('in_stock') || 'متوفر' }}
      </span>
    </div>
    
    <div class="pname" :title="product.name">{{ product.name }}</div>
    
    <div class="pricerow">
      <span class="price">
        {{ product.front_sale_price_format || product.price_format || product.price }}
      </span>
      <span v-if="product.is_on_sale" class="old">{{ product.price_format }}</span>
    </div>
    
    <div class="bnpl" v-if="product.accepts_taly || product.accepts_deema">
      <div class="bt">
        <span>{{ __('pay_in_4') || 'قسطها على 4 دفعات' }}</span>
        <b>
          <template v-if="product.front_sale_price">
            {{ (parseFloat(product.front_sale_price) / 4).toFixed(3) }}
          </template>
          <template v-else>
            {{ (parseFloat(product.price) / 4).toFixed(3) }}
          </template>
           <small>/ {{ __('mo') || 'شهر' }}</small>
        </b>
      </div>
      <div class="pay-t" style="background:var(--surface);border-radius:6px;padding:2px 4px;font-weight:800;font-size:10px;color:var(--primary)">
        {{ product.accepts_taly ? 'TALY' : 'DEEMA' }}
      </div>
    </div>
    
    <button class="addbtn" @click.stop="addToCart(product.id)" :disabled="product.stock_status === 'out_of_stock'">
      <template v-if="product.stock_status === 'out_of_stock'">
        <i class="ti ti-circle-x" style="font-size:16px;"></i> {{ __('out_of_stock') || 'غير متوفر' }}
      </template>
      <template v-else-if="product.stock_status === 'on_backorder'">
        <i class="ti ti-clock" style="font-size:16px;"></i> {{ __('pre_order') || 'طلب مسبق' }}
      </template>
      <template v-else>
        <i class="ti ti-shopping-cart" style="font-size:16px;"></i> {{ __('add_to_cart') || 'أضف للسلة' }}
      </template>
    </button>
  </div>
</template>

<script setup>
import { __ } from '../utils/i18n';
import { inject } from 'vue';
import { useEcommerceStore } from '../stores/ecommerce';

const props = defineProps({
  product: {
    type: Object,
    required: true
  }
});

const store = useEcommerceStore();
const botbleData = window?.BotbleData || {};

const addToCart = async (productId) => {
    const success = await store.addToCart(productId, 1);
    if (success) {
        store.notify(__('added_to_cart') || 'تمت الإضافة للسلة بنجاح!', 'success');
    } else {
        store.notify(__('add_to_cart_error') || 'حدث خطأ أثناء الإضافة للسلة.', 'error');
    }
};
</script>

<style scoped>
/* الإطار العام */
.card {
  background: var(--surface);
  border: 1px solid var(--border2);
  border-radius: var(--r12);
}

.pcard {
  position: relative;
  padding: 10px 10px 12px;
  display: flex;
  flex-direction: column;
  gap: 8px;
  cursor: pointer;
  transition: transform .28s ease, border-color .2s, box-shadow .3s;
}
.pcard:hover {
  transform: translateY(-6px);
  border-color: var(--primary);
  box-shadow: 0 10px 20px rgba(0,0,0,0.08);
}
.part {
  position: relative;
  background: linear-gradient(150deg, var(--surface2), var(--surface));
  border-radius: 13px;
  height: 180px;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}
.part > img {
  width: 90%;
  height: 90%;
  object-fit: contain;
  transition: transform .45s ease;
}
.pcard:hover .part > img {
  transform: scale(1.09) rotate(-1.5deg);
}

.pbadges {
  position: absolute;
  top: 9px;
  inset-inline-start: 9px;
  display: flex;
  flex-direction: column;
  gap: 5px;
  z-index: 2;
  align-items: flex-start;
}
.chipb {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  font-size: 10px;
  font-weight: 800;
  color: #fff;
  padding: 4px 8px;
  border-radius: 8px;
  box-shadow: 0 6px 14px -6px rgba(0,0,0,.35);
}
.chipb i {
  flex: none;
}

.off {
  position: absolute;
  top: 9px;
  inset-inline-end: 9px;
  z-index: 2;
  background: var(--danger);
  color: #fff;
  font-size: 11px;
  font-weight: 800;
  padding: 4px 9px;
  border-radius: 8px;
}

/* Floating Actions */
.pcard-actions {
  position: absolute;
  bottom: 10px;
  inset-inline-end: 10px;
  display: flex;
  flex-direction: column;
  gap: 8px;
  z-index: 2;
  opacity: 0;
  transform: translateX(10px);
  transition: all 0.3s ease;
}
html[dir="rtl"] .pcard-actions {
  transform: translateX(-10px);
}
.pcard:hover .pcard-actions {
  opacity: 1;
  transform: translateX(0);
}
.action-btn {
  width: 32px;
  height: 32px;
  border-radius: 8px;
  background: rgba(255,255,255,0.9);
  backdrop-filter: blur(4px);
  border: 1px solid var(--border2);
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--text);
  box-shadow: 0 4px 10px rgba(0,0,0,0.05);
  transition: all 0.2s;
}
.action-btn:hover, .action-btn.active {
  background: var(--primary-strong);
  color: var(--on-primary);
  border-color: var(--primary);
}

.rrow {
  display: flex;
  align-items: center;
  gap: 5px;
  font-size: 11.5px;
}
.rrow .stars {
  display: flex;
}
.rrow b {
  font-weight: 800;
  color: var(--text);
}
.rrow .rc {
  color: var(--text3);
}
.rrow .stk {
  margin-inline-start: auto;
  display: inline-flex;
  align-items: center;
  gap: 5px;
  color: var(--success-text);
  font-weight: 700;
  font-size: 10.5px;
}
.rrow .stk i {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: var(--success);
  box-shadow: 0 0 0 3px var(--success-bg);
}

.pname {
  font-size: 13px;
  font-weight: 700;
  line-height: 1.5;
  min-height: 39px;
  color: var(--text);
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.pricerow {
  display: flex;
  align-items: baseline;
  gap: 8px;
}
.price {
  font-size: 16.5px;
  font-weight: 800;
  color: var(--primary);
}
.old {
  font-size: 11.5px;
  color: var(--text3);
  text-decoration: line-through;
}

.bnpl {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
  background: var(--primary-light);
  border: 1px solid rgba(33, 147, 176, 0.15);
  border-radius: 11px;
  padding: 7px 9px;
}
.bnpl .bt span {
  display: block;
  font-size: 9.5px;
  color: var(--text2);
  font-weight: 700;
  line-height: 1.3;
}
.bnpl .bt b {
  font-size: 12px;
  font-weight: 800;
  color: var(--text);
}
.bnpl .bt small {
  font-size: 9.5px;
  color: var(--text3);
  font-weight: 700;
}

.addbtn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  width: 100%;
  height: 38px;
  border-radius: 11px;
  background: var(--surface2);
  color: var(--primary);
  font-size: 13px;
  font-weight: 800;
  border: 1px solid var(--border2);
  transition: background .18s, color .18s, transform .12s, border-color .18s;
  margin-top: auto;
}
.pcard:hover .addbtn {
  background: var(--primary-strong);
  color: var(--on-primary);
  border-color: var(--primary);
}
.addbtn:active {
  transform: scale(.96);
}
.addbtn:disabled {
  background: var(--surface2) !important;
  color: var(--text3) !important;
  border-color: var(--border2) !important;
  cursor: not-allowed;
  opacity: 0.7;
}
</style>
