<template>
  <div class="skeleton-wrapper" :class="type">
    <template v-if="type === 'product'">
      <div class="skeleton-pcard">
        <div class="skeleton-img skeleton-shimmer"></div>
        <div class="skeleton-info">
          <div class="skeleton-line title-line skeleton-shimmer"></div>
          <div class="skeleton-line subtitle-line skeleton-shimmer"></div>
          <div class="skeleton-specs">
            <div class="skeleton-badge skeleton-shimmer"></div>
            <div class="skeleton-badge skeleton-shimmer"></div>
          </div>
          <div class="skeleton-price-row">
            <div class="skeleton-price skeleton-shimmer"></div>
            <div class="skeleton-btn skeleton-shimmer"></div>
          </div>
        </div>
      </div>
    </template>
    <template v-else-if="type === 'category'">
      <div class="skeleton-animated-card">
        <div class="skeleton-cat-card-inner skeleton-shimmer">
           <div class="skeleton-cat-img skeleton-shimmer"></div>
           <div class="skeleton-cat-name skeleton-shimmer"></div>
        </div>
      </div>
    </template>
  </div>
</template>

<script setup>
defineProps({
  type: {
    type: String,
    default: 'product',
    validator: (value) => ['product', 'category'].includes(value)
  }
});
</script>

<style scoped>
.skeleton-shimmer {
  background: var(--surface2);
  background-image: linear-gradient(
    90deg,
    rgba(255, 255, 255, 0) 0,
    rgba(255, 255, 255, 0.05) 20%,
    rgba(255, 255, 255, 0.1) 60%,
    rgba(255, 255, 255, 0)
  );
  background-size: 200% 100%;
  animation: shimmer 1.5s infinite linear;
  border-radius: var(--r6);
}

[data-theme="dark"] .skeleton-shimmer {
  background: var(--surface2);
  background-image: linear-gradient(
    90deg,
    rgba(255, 255, 255, 0) 0,
    rgba(255, 255, 255, 0.02) 20%,
    rgba(255, 255, 255, 0.05) 60%,
    rgba(255, 255, 255, 0)
  );
}

@keyframes shimmer {
  0% { background-position: -200% 0; }
  100% { background-position: 200% 0; }
}

/* Product Skeleton */
.skeleton-pcard {
  background: var(--bg);
  border-radius: var(--r10);
  border: 1px solid var(--border2);
  overflow: hidden;
  height: 100%;
  display: flex;
  flex-direction: column;
}
.skeleton-img {
  width: 100%;
  aspect-ratio: 1;
  border-radius: 0;
}
.skeleton-info {
  padding: 15px;
  display: flex;
  flex-direction: column;
  gap: 10px;
  flex: 1;
}
.skeleton-line {
  height: 14px;
  border-radius: 4px;
}
.title-line { width: 80%; }
.subtitle-line { width: 50%; }
.skeleton-specs {
  display: flex;
  gap: 5px;
  margin-top: 5px;
  margin-bottom: auto;
}
.skeleton-badge {
  width: 40px;
  height: 16px;
  border-radius: 10px;
}
.skeleton-price-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 10px;
}
.skeleton-price {
  width: 60px;
  height: 20px;
}
.skeleton-btn {
  width: 90px;
  height: 36px;
  border-radius: var(--r6);
}

/* Category Skeleton */
.skeleton-animated-card {
  width: 105px;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.skeleton-cat-card-inner {
  width: 100%;
  height: 125px;
  border-radius: var(--r12);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 10px;
}
.skeleton-cat-img {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  margin-bottom: 10px;
}
.skeleton-cat-name {
  width: 60px;
  height: 12px;
  border-radius: 4px;
}
</style>
