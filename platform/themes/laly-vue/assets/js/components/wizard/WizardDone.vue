<template>
<section class="done">
  <div class="done-ic">
    <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 6L9 17l-5-5"/></svg>
  </div>
  <h2>وصلنا طلبك يا {{ lead.name || 'عزيزنا' }}</h2>
  <p>سنتواصل معك خلال 24 ساعة على {{ lead.phone }} لتحديد موعد المعاينة المجانية وتأكيد العرض النهائي.</p>
  <p v-if="serverEstimate !== null" class="done-estimate">التكلفة التقديرية لباقتك: ~{{ Math.round(serverEstimate) }} د.ك</p>
</section>
</template>

<script setup>
// Shown after the lead was stored.
import { inject } from 'vue';

const { lead, serverEstimate } = inject('wizard');
</script>
