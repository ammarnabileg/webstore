<template>
  <div v-if="isOpen" class="qvm-overlay" @click="closeModal">
    <div class="qvm-container" @click.stop :class="{ 'rtl': botbleData?.is_rtl }">
      <button class="qvm-close" @click="closeModal"><i class="ti ti-x"></i></button>
      
      <div v-if="loading" class="qvm-loading">
        <div class="spinner"></div>
      </div>
      
      <div v-else-if="product" class="qvm-content">
        <!-- Product Image -->
        <div class="qvm-img-wrap">
          <img :src="product.image || botbleData?.placeholderImage" :alt="product.name" class="qvm-img" />
          <div v-if="product.is_on_sale" class="pcard-badge sale-badge" style="position:absolute; top:15px; right:15px;">{{ __('sale') || 'خصم' }}</div>
        </div>
        
        <!-- Product Details -->
        <div class="qvm-details">
          <div class="qvm-meta" v-if="product.collections?.length || product.tags?.length">
            <span v-if="product.collections?.length">{{ product.collections[0].name }}</span>
            <span v-else-if="product.tags?.length">{{ product.tags[0].name }}</span>
          </div>
          
          <h2 class="qvm-title">{{ product.name }}</h2>
          
          <div class="qvm-price">
            <span class="current-price">{{ product.front_sale_price_format || product.price_format || product.price }}</span>
            <span v-if="product.is_on_sale" class="old-price">{{ product.price_format }}</span>
          </div>
          
          <div class="qvm-stock" :class="{'in-stock': product.stock_status === 'in_stock' || !product.stock_status, 'out-of-stock': product.stock_status === 'out_of_stock', 'backorder': product.stock_status === 'on_backorder'}">
            <i :class="product.stock_status === 'out_of_stock' ? 'ti ti-circle-x' : (product.stock_status === 'on_backorder' ? 'ti ti-clock' : 'ti ti-circle-check')"></i>
            {{ product.stock_status === 'out_of_stock' ? (__('out_of_stock') || 'غير متوفر') : (product.stock_status === 'on_backorder' ? (__('pre_order') || 'طلب مسبق') : (__('in_stock') || 'متوفر')) }}
          </div>
          
          <!-- Options Placeholder (If product has variants) -->
          <div class="qvm-options" v-if="product.variations && product.variations.length > 0">
            <!-- Render options here if needed later -->
          </div>
          
          <!-- Actions -->
          <div class="qvm-actions">
            <div class="qty-selector">
              <button @click="qty > 1 ? qty-- : null"><i class="ti ti-minus"></i></button>
              <input type="number" v-model="qty" min="1" readonly />
              <button @click="qty++"><i class="ti ti-plus"></i></button>
            </div>
            
            <button class="btn btn-primary qvm-add-btn" @click="addToCart" :disabled="product.stock_status === 'out_of_stock'">
              <template v-if="product.stock_status === 'out_of_stock'">
                <i class="ti ti-circle-x"></i> {{ __('out_of_stock') || 'غير متوفر' }}
              </template>
              <template v-else-if="product.stock_status === 'on_backorder'">
                <i class="ti ti-clock"></i> {{ __('pre_order') || 'طلب مسبق' }}
              </template>
              <template v-else>
                <i class="ti ti-shopping-cart"></i> {{ __('add_to_cart') || 'أضف للسلة' }}
              </template>
            </button>
          </div>
          
          <a :href="`/product/${product.slug}`" class="qvm-full-details">{{ __('view_full_details') || 'عرض التفاصيل الكاملة' }} <i class="ti ti-arrow-left" :class="{ 'ti-arrow-right': !botbleData?.is_rtl }"></i></a>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { __ } from '../utils/i18n';
import { ref, computed, inject } from 'vue';
import { useEcommerceStore } from '../stores/ecommerce';

const store = useEcommerceStore();
const botbleData = window?.BotbleData || {};

const qty = ref(1);

const isOpen = computed(() => store.quickViewOpen);
const loading = computed(() => store.quickViewLoading);
const product = computed(() => store.quickViewProduct);

const closeModal = () => {
    store.quickViewOpen = false;
    setTimeout(() => { store.quickViewProduct = null; }, 300); // Clear after animation
    qty.value = 1;
};

const addToCart = async () => {
    if (!product.value || product.value.is_out_of_stock) return;
    const success = await store.addToCart(product.value.id, qty.value);
    if (success) {
        store.notify(__('added_to_cart') || 'تمت الإضافة للسلة بنجاح!', 'success');
        closeModal();
    } else {
        store.notify(__('add_to_cart_error') || 'حدث خطأ أثناء الإضافة للسلة.', 'error');
    }
};
</script>

<style scoped>
.qvm-overlay {
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(0,0,0,0.5);
  z-index: 99999;
  display: flex;
  align-items: center;
  justify-content: center;
  backdrop-filter: blur(4px);
  -webkit-backdrop-filter: blur(4px);
  animation: fadeIn 0.2s;
}
.qvm-container {
  background: #fff;
  border-radius: 20px;
  width: 90%;
  max-width: 800px;
  max-height: 90vh;
  position: relative;
  display: flex;
  overflow: hidden;
  box-shadow: 0 10px 40px rgba(0,0,0,0.15);
  animation: slideUp 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}
@media (max-width: 767px) {
  .qvm-overlay { align-items: flex-end; }
  .qvm-container {
    width: 100%; max-width: 100%;
    border-radius: 20px 20px 0 0;
    flex-direction: column;
    max-height: 85vh;
    animation: slideUpMobile 0.3s cubic-bezier(0.16, 1, 0.3, 1);
  }
}

.qvm-close {
  position: absolute;
  top: 15px; right: 15px;
  width: 36px; height: 36px;
  background: #f5f5f5;
  border-radius: 50%;
  display: flex; align-items: center; justify-content: center;
  font-size: 18px; color: #555;
  z-index: 10; transition: background 0.2s;
}
.qvm-container.rtl .qvm-close { right: auto; left: 15px; }
.qvm-close:hover { background: #e0e0e0; }

.qvm-loading { padding: 50px; display: flex; justify-content: center; width: 100%; }

.qvm-content { display: flex; width: 100%; }
@media (max-width: 767px) { .qvm-content { flex-direction: column; overflow-y: auto; } }

.qvm-img-wrap {
  width: 45%; padding: 30px;
  background: #fcfcfc;
  display: flex; align-items: center; justify-content: center;
  position: relative;
}
@media (max-width: 767px) { .qvm-img-wrap { width: 100%; padding: 20px; height: 300px; } }
.qvm-img { max-width: 100%; max-height: 100%; object-fit: contain; }

.qvm-details {
  width: 55%; padding: 30px 40px;
  display: flex; flex-direction: column; justify-content: center;
}
@media (max-width: 767px) { .qvm-details { width: 100%; padding: 20px; } }

.qvm-meta { font-size: 12px; color: var(--primary); text-transform: uppercase; letter-spacing: 1px; font-weight: 700; margin-bottom: 8px; }
.qvm-title { font-size: 22px; font-weight: 800; color: #222; margin-bottom: 12px; line-height: 1.3; }
.qvm-price { display: flex; align-items: center; gap: 10px; margin-bottom: 15px; }
.qvm-price .current-price { font-size: 22px; font-weight: 800; color: var(--primary); }
.qvm-price .old-price { font-size: 15px; color: #999; text-decoration: line-through; }

.qvm-stock { display: flex; align-items: center; gap: 5px; font-size: 13px; font-weight: 600; color: var(--danger); margin-bottom: 25px; }
.qvm-stock.in-stock { color: var(--success-text); }

.qvm-actions { display: flex; gap: 15px; margin-bottom: 20px; }
@media (max-width: 767px) { .qvm-actions { flex-direction: column; } }

.qty-selector { display: flex; align-items: center; background: #f5f5f5; border-radius: 8px; padding: 5px; height: 46px; }
.qty-selector button { width: 36px; height: 100%; display: flex; align-items: center; justify-content: center; color: #555; }
.qty-selector input { width: 40px; height: 100%; text-align: center; border: none; background: transparent; font-weight: bold; }

.qvm-add-btn { flex: 1; height: 46px; border-radius: 8px; font-size: 15px; display: flex; align-items: center; justify-content: center; gap: 8px; }

.qvm-full-details { display: inline-flex; align-items: center; gap: 5px; font-size: 14px; color: #666; font-weight: 600; margin-top: auto; transition: color 0.2s; }
.qvm-full-details:hover { color: var(--primary); }

@keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
@keyframes slideUp { from { opacity: 0; transform: translateY(30px) scale(0.98); } to { opacity: 1; transform: translateY(0) scale(1); } }
@keyframes slideUpMobile { from { transform: translateY(100%); } to { transform: translateY(0); } }
</style>
