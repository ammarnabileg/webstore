<template>
<div class="lead-form">
  <div class="field">
    <label for="name">اسمك</label>
    <input id="name" v-model.trim="lead.name" type="text" autocomplete="name" placeholder="الاسم" />
  </div>
  <div class="field">
    <label for="phone">رقم الهاتف</label>
    <input id="phone" v-model.trim="lead.phone" type="tel" inputmode="tel" autocomplete="tel" placeholder="مثال: 5xxxxxxx" @blur="phoneTouched=true" />
    <div class="err" v-if="phoneTouched && !phoneValid">أدخل رقمًا كويتيًا صحيحًا من 8 أرقام.</div>
  </div>
  <div class="hp-field" aria-hidden="true">
    <label for="sw-website">اترك هذا الحقل فارغًا</label>
    <input id="sw-website" v-model="honeypot" type="text" tabindex="-1" autocomplete="off" />
  </div>
  <p class="privacy">تُستخدم بياناتك للتواصل بخصوص طلبك فقط.</p>
  <div class="err" v-if="submitError" role="alert">{{ submitError }}</div>

  <a class="wa" v-if="waLink" :href="waLink" target="_blank" rel="noopener">
    <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 0 0-8.6 15.1L2 22l5-1.3A10 10 0 1 0 12 2zm5.4 14.1c-.2.6-1.3 1.2-1.8 1.2-.5.1-1 .2-3.4-.7-2.9-1.2-4.7-4.1-4.9-4.3-.1-.2-1.1-1.5-1.1-2.9s.7-2 1-2.3c.2-.3.5-.3.7-.3h.5c.2 0 .4 0 .6.4l.9 2.1c.1.2.1.4 0 .6l-.4.6c-.1.2-.3.4-.1.7.1.3.7 1.2 1.6 1.9 1.1.9 2 1.2 2.3 1.4.3.1.5.1.6-.1l.8-.9c.2-.2.4-.2.6-.1l2 .9c.2.1.4.2.4.3.1.1.1.6-.3 1.5z"/></svg>
    أو أرسل الطلب عبر واتساب
  </a>
</div>
</template>

<script setup>
// Name, phone, honeypot and the WhatsApp alternative.
import { inject } from 'vue';

const { lead, phoneTouched, phoneValid, honeypot, submitError, waLink } = inject('wizard');
</script>
