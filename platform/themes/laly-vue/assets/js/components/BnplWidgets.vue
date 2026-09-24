<template>
  <div class="bnpl-widgets-container" v-if="acceptsTaly || acceptsDeema">
    <!-- Taly Widget -->
    <div class="bnpl-widget taly-widget-wrapper" v-if="acceptsTaly">
      <iframe 
        :src="`https://widget.taly.io/installment-widget?price=${price}&installmenttype=4&lang=${lang}`" 
        width="100%" 
        style="border: none; height: 75px; overflow: hidden; display: block;"
        scrolling="no">
      </iframe>
    </div>

    <!-- Deema Widget -->
    <div class="bnpl-widget deema-widget-wrapper" v-if="acceptsDeema">
      <deema-widget :amount="price" currency="KWD"></deema-widget>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue';

const props = defineProps({
  price: {
    type: Number,
    required: true
  },
  acceptsTaly: {
    type: Boolean,
    default: false
  },
  acceptsDeema: {
    type: Boolean,
    default: false
  }
});

const lang = computed(() => {
  const locale = document.documentElement.lang || 'en';
  return locale.startsWith('ar') ? 'ar' : 'en';
});
</script>

<style scoped>
.bnpl-widgets-container {
  margin: 15px 0;
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.bnpl-widget {
  width: 100%;
  border-radius: 8px;
  overflow: hidden;
  /* Removed background and border to let the widgets native design shine */
  display: flex;
  justify-content: center;
  align-items: center;
}
.deema-widget-wrapper {
  min-height: 50px;
}
</style>
