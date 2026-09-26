<template>
  <div class="page">
    <div class="nbar">
      <button class="nbar-back" @click="$router.back()" :aria-label="__('back')">
        <i class="ti ti-arrow-right" :class="{ 'ti-arrow-left': !botbleData?.is_rtl }"></i>
      </button>
      <div class="nbar-title">{{ __('track_order') }}</div>
    </div>

    <div class="scroll" style="padding: 16px;">
      <form class="track-form" @submit.prevent="track">
        <p class="track-hint">{{ usingPhone ? __('track_hint_phone') : __('track_hint_email') }}</p>
        <div class="track-field">
          <label>{{ __('order_code') }}</label>
          <input type="text" v-model.trim="code" :placeholder="__('order_code')" required />
        </div>
        <div class="track-field" v-if="usingPhone">
          <label>{{ __('phone') }}</label>
          <input type="text" v-model.trim="phone" :placeholder="__('phone_placeholder')" required />
        </div>
        <div class="track-field" v-else>
          <label>{{ __('email') }}</label>
          <input type="email" v-model.trim="email" placeholder="you@example.com" required />
        </div>
        <button type="submit" class="track-btn" :disabled="loading">
          {{ loading ? __('loading') : __('track_order') }}
        </button>
      </form>

      <p v-if="error" class="track-error">{{ error }}</p>

      <div v-if="order" class="track-result">
        <div class="tr-head">
          <div>
            <div class="tr-code">{{ order.code }}</div>
            <div class="tr-date" v-if="order.created_at">{{ formatDate(order.created_at) }}</div>
          </div>
          <span class="tr-status">{{ order.status }}</span>
        </div>

        <div class="tr-items">
          <div v-for="(item, i) in order.items" :key="i" class="tr-item">
            <img :src="item.image" :alt="item.name" loading="lazy" />
            <div class="tr-item-info">
              <div class="tr-item-name">{{ item.name }}</div>
              <div class="tr-item-meta">{{ item.qty }} × {{ item.price_format }}</div>
            </div>
          </div>
        </div>

        <div class="tr-totals">
          <div v-if="order.shipment_status"><span>{{ __('shipping') }}:</span> {{ order.shipment_status }}</div>
          <div v-if="order.payment_status"><span>{{ __('payment') }}:</span> {{ order.payment_status }}</div>
          <div class="tr-total"><span>{{ __('total') }}:</span> {{ order.amount_format }}</div>
        </div>

        <div class="tr-history" v-if="order.histories && order.histories.length">
          <h4>{{ __('order_history') }}</h4>
          <ul>
            <li v-for="(h, i) in order.histories" :key="i">
              <span class="tr-hist-desc">{{ h.description || h.action }}</span>
              <span class="tr-hist-date" v-if="h.created_at">{{ formatDate(h.created_at) }}</span>
            </li>
          </ul>
        </div>
      </div>

      <div style="height: 80px;"></div>
    </div>
  </div>
</template>

<script setup>
import { __ } from '../utils/i18n';
import { ref, onMounted } from 'vue';
import api from '../services/api';

const botbleData = window?.BotbleData || {};
const usingPhone = ref(false);
const code = ref('');
const email = ref('');
const phone = ref('');
const order = ref(null);
const error = ref('');
const loading = ref(false);

const formatDate = (iso) => {
  try { return new Date(iso).toLocaleDateString(botbleData.is_rtl ? 'ar' : 'en'); } catch (e) { return iso; }
};

onMounted(async () => {
  try {
    const res = await api.get('/orders/track/settings');
    usingPhone.value = res.data?.data?.method === 'phone';
  } catch (e) { /* default to email */ }
});

const track = async () => {
  error.value = '';
  order.value = null;
  loading.value = true;
  try {
    const payload = { code: code.value };
    if (usingPhone.value) payload.phone = phone.value; else payload.email = email.value;
    const res = await api.post('/orders/track', payload);
    if (res.data && !res.data.error) {
      order.value = res.data.data.order;
    } else {
      error.value = res.data?.message || __('order_not_found');
    }
  } catch (e) {
    const data = e?.response?.data;
    error.value = data?.message
      || (data?.errors ? Object.values(data.errors).flat()[0] : null)
      || __('order_not_found');
  } finally {
    loading.value = false;
  }
};
</script>

<style scoped>
.track-form {
  background: var(--bg);
  border: 1px solid var(--border2, var(--line));
  border-radius: 15px;
  padding: 18px;
  margin-bottom: 18px;
}
.track-hint {
  color: var(--text2, var(--ink-2));
  font-size: 14px;
  margin: 0 0 14px;
}
.track-field {
  margin-bottom: 12px;
}
.track-field label {
  display: block;
  font-size: 13px;
  font-weight: 600;
  margin-bottom: 6px;
  color: var(--text);
}
.track-field input {
  width: 100%;
  padding: 12px;
  border-radius: 10px;
  border: 1px solid var(--line);
  background: var(--surface);
  color: var(--text);
  font-family: inherit;
}
.track-btn {
  width: 100%;
  padding: 12px;
  border: none;
  border-radius: 10px;
  background: var(--primary-strong);
  color: var(--on-primary);
  font-weight: 700;
  cursor: pointer;
}
.track-btn:disabled { opacity: .6; cursor: default; }
.track-error {
  color: var(--sale, #d93a3a);
  font-weight: 600;
  text-align: center;
  margin: 8px 0;
}
.track-result {
  background: var(--bg);
  border: 1px solid var(--border2, var(--line));
  border-radius: 15px;
  padding: 18px;
}
.tr-head {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  border-bottom: 1px solid var(--border2, var(--line));
  padding-bottom: 12px;
  margin-bottom: 12px;
}
.tr-code { font-weight: 700; font-size: 16px; color: var(--text); }
.tr-date { font-size: 12px; color: var(--text2, var(--ink-2)); margin-top: 4px; }
.tr-status {
  background: var(--primary-soft, var(--surface-2));
  color: var(--primary-strong);
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 13px;
  font-weight: 600;
  white-space: nowrap;
}
.tr-item {
  display: flex;
  gap: 12px;
  align-items: center;
  padding: 8px 0;
}
.tr-item img { width: 48px; height: 48px; border-radius: 8px; object-fit: cover; background: var(--surface-2); }
.tr-item-name { font-size: 14px; color: var(--text); }
.tr-item-meta { font-size: 12px; color: var(--text2, var(--ink-2)); }
.tr-totals {
  border-top: 1px solid var(--border2, var(--line));
  margin-top: 12px;
  padding-top: 12px;
  font-size: 14px;
  color: var(--text);
}
.tr-totals > div { display: flex; justify-content: space-between; padding: 3px 0; }
.tr-totals span { color: var(--text2, var(--ink-2)); }
.tr-total { font-weight: 700; }
.tr-history { margin-top: 16px; }
.tr-history h4 { font-size: 14px; margin: 0 0 8px; }
.tr-history ul { list-style: none; padding: 0; margin: 0; }
.tr-history li {
  display: flex;
  justify-content: space-between;
  gap: 10px;
  font-size: 13px;
  padding: 6px 0;
  border-bottom: 1px dashed var(--border2, var(--line));
}
.tr-hist-desc { color: var(--text); }
.tr-hist-date { color: var(--text2, var(--ink-2)); white-space: nowrap; }
</style>
