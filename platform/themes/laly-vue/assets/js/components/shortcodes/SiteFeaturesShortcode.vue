<template>
  <div class="site-features-block sblock">
    <div class="features-grid">
      <div class="feature-item" v-for="feature in features" :key="feature.id">
        <div class="f-icon">
          <i :class="feature.icon" v-if="feature.icon"></i>
        </div>
        <div class="f-content">
          <h4>{{ feature.title }}</h4>
          <p>{{ feature.subtitle }}</p>
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

const features = computed(() => {
  const list = [];
  for (let i = 1; i <= 5; i++) {
    if (props.attributes['title' + i] || props.attributes['icon' + i]) {
      list.push({
        id: i,
        icon: props.attributes['icon' + i] || '',
        title: props.attributes['title' + i] || '',
        subtitle: props.attributes['subtitle' + i] || ''
      });
    }
  }
  return list;
});
</script>

<style scoped>
.site-features-block {
  padding: 15px 0;
}
.features-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
  background: #fff;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.03);
}
.feature-item {
  display: flex;
  align-items: center;
  gap: 15px;
}
.f-icon {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  background: var(--primary-light, rgba(0, 102, 204, 0.1));
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--primary);
  font-size: 24px;
}
.f-content h4 {
  margin: 0 0 5px 0;
  font-size: 15px;
  font-weight: 600;
  color: #333;
}
.f-content p {
  margin: 0;
  font-size: 13px;
  color: #777;
}

@media (max-width: 991px) {
  .features-grid {
    grid-template-columns: repeat(2, 1fr);
    padding: 20px;
  }
}
@media (max-width: 575px) {
  .features-grid {
    grid-template-columns: 1fr;
    gap: 15px;
  }
  .feature-item {
    padding-bottom: 15px;
    border-bottom: 1px solid #f5f5f5;
  }
  .feature-item:last-child {
    padding-bottom: 0;
    border-bottom: none;
  }
}
</style>
