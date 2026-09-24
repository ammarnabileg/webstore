<template>
  <div class="theme-ads-block sblock" v-if="hasAds">
    <div class="ads-grid">
      <!-- Ads Placeholder until API is fully supported -->
      <div class="ad-item" v-for="key in adKeys" :key="key">
        <div class="ad-placeholder">
          <span>Ad Banner ({{ key }})</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue';

const props = defineProps({
  attributes: {
    type: Object,
    default: () => ({})
  }
});

const adKeys = computed(() => {
  const keys = [];
  for (let i = 1; i <= 5; i++) {
    const key = props.attributes[`key_${i}`];
    if (key) {
      keys.push(key);
    }
  }
  return keys;
});

const hasAds = computed(() => adKeys.value.length > 0);
</script>

<style scoped>
.theme-ads-block {
  margin-top: 20px;
}
.ads-grid {
  display: flex;
  gap: 20px;
}
.ad-item {
  flex: 1;
}
.ad-placeholder {
  background: var(--surface-2);
  border-radius: 10px;
  height: 150px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--ink-2);
  font-weight: 500;
  border: 1px dashed var(--line);
}
@media (max-width: 767px) {
  .ads-grid {
    flex-direction: column;
  }
}
</style>
