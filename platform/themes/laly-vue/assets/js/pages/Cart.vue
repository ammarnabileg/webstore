<template>
  <div class="page">
    <div class="nbar">
      <div class="nbar-title">{{ __('cart') }}</div>
    </div>
    
    <div class="scroll" style="padding: 16px;">
      <div v-if="!store.cart" class="loading-state">
        <div class="spinner"></div>
      </div>

      <div v-else-if="store.cartCount === 0" class="empty-cart">
        <div class="ec-icon"><i class="ti ti-shopping-cart-x"></i></div>
        <h3>{{ __('cart_empty_title') }}</h3>
        <p>{{ __('cart_empty_sub') }}</p>
        <button class="ec-btn" @click="$router.push('/products')">{{ __('browse_products') }}</button>
      </div>

      <div v-else class="cart-wrapper">
        <div class="cart-items">
          <div class="cart-item" v-for="item in store.cart.items" :key="item.id">
            <div class="ci-img">
              <img loading="lazy" :src="item.product_image || botbleData?.placeholderImage" :alt="item.name">
            </div>
            <div class="ci-info">
              <div class="ci-name">{{ item.name }}</div>
              <div class="ci-price">{{ item.price_format }}</div>
              <div class="ci-actions">
                <div class="qty-selector">
                  <button class="qty-btn" @click="updateQty(item, -1)" :disabled="item.qty <= 1" :aria-label="__('decrease_qty')"><i class="ti ti-minus"></i></button>
                  <span class="qty-text">{{ item.qty }}</span>
                  <button class="qty-btn" @click="updateQty(item, 1)" :aria-label="__('increase_qty')"><i class="ti ti-plus"></i></button>
                </div>
                <button class="ci-remove" @click="removeItem(item.rowId)" :aria-label="__('remove')">
                  <i class="ti ti-trash"></i>
                </button>
              </div>
            </div>
          </div>
        </div>

        <div class="cart-summary">
          <div class="cs-row">
            <span>{{ __('sub_total') }}</span>
            <span>{{ store.cart.sub_total_format }}</span>
          </div>
          <div class="cs-row" v-if="store.cart.tax_amount > 0">
            <span>{{ __('tax') }}</span>
            <span>{{ store.cart.tax_amount_format }}</span>
          </div>
          <div class="cs-row cs-total">
            <span>{{ __('cart_total') }}</span>
            <span>{{ store.cart.total_format }}</span>
          </div>
          <button class="checkout-btn" @click="goToCheckout">{{ __('checkout') }}</button>
        </div>
      </div>
      
      <div style="height: 80px;"></div>
    </div>
  </div>
</template>

<script setup>
import { onMounted } from 'vue';
import { useEcommerceStore } from '../stores/ecommerce';

const store = useEcommerceStore();
const botbleData = window?.BotbleData || {};

onMounted(() => {
    store.fetchCart();
});

const removeItem = async (rowId) => {
    await store.removeCartItem(rowId);
};

const goToCheckout = () => {
    const checkoutUrl = window?.BotbleData?.checkoutUrl || '/checkout';
    window.location.href = checkoutUrl;
};

const updateQty = async (item, change) => {
    const newQty = item.qty + change;
    if (newQty >= 1) {
        await store.updateCartItem(item.rowId, newQty);
    }
};
</script>

<style scoped>
.empty-cart {
  text-align: center;
  padding: 50px 20px;
}
.ec-icon {
  font-size: 60px;
  color: var(--line);
  margin-bottom: 20px;
}
.ec-btn {
  background: var(--primary-strong);
  color: var(--on-primary);
  border: none;
  padding: 12px 30px;
  border-radius: 25px;
  font-size: 16px;
  font-weight: bold;
  margin-top: 20px;
  cursor: pointer;
}
.cart-item {
  display: flex;
  background: var(--surface);
  padding: 15px;
  border-radius: 15px;
  margin-bottom: 15px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.02);
}
.ci-img {
  width: 80px;
  height: 80px;
  margin-inline-end: 15px;
  border-radius: 10px;
  background: var(--surface-2);
  display: flex;
  align-items: center;
  justify-content: center;
}
.ci-img img {
  max-width: 100%;
  max-height: 100%;
}
.ci-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.ci-name {
  font-weight: bold;
  color: var(--ink);
}
.ci-price {
  color: var(--primary-strong);
  font-weight: bold;
}
.ci-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.qty-selector {
  display: flex;
  align-items: center;
  background: var(--surface-2);
  border-radius: 20px;
  padding: 5px 10px;
  gap: 15px;
}
.qty-btn {
  background: none;
  border: none;
  color: var(--ink-2);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
}
.qty-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}
.qty-text {
  font-weight: bold;
  font-size: 15px;
  color: var(--ink);
}
.ci-remove {
  background: none;
  border: none;
  color: var(--sale);
  cursor: pointer;
  padding: 5px;
}
.cart-summary {
  background: var(--surface);
  padding: 20px;
  border-radius: 15px;
  margin-top: 20px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.02);
}
.cs-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
  color: var(--ink-2);
}
.cs-total {
  font-size: 18px;
  font-weight: bold;
  color: var(--ink);
  border-top: 1px solid var(--line);
  padding-top: 15px;
  margin-top: 15px;
}
.checkout-btn {
  width: 100%;
  background: var(--primary-strong);
  color: var(--on-primary);
  border: none;
  padding: 15px;
  border-radius: 25px;
  font-size: 16px;
  font-weight: bold;
  margin-top: 20px;
  cursor: pointer;
}

/* Desktop */
@media (min-width: 768px) {
  .cart-wrapper {
    display: flex;
    gap: 30px;
    align-items: flex-start;
  }
  .cart-items {
    flex: 2;
  }
  .cart-summary {
    flex: 1;
    position: sticky;
    top: 80px;
    margin-top: 0;
  }
}
</style>
