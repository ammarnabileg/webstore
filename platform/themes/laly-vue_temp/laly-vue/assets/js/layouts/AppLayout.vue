<template>
  <div class="page">
    <router-view v-slot="{ Component }">
      <transition name="fade" mode="out-in">
        <component :is="Component" />
      </transition>
    </router-view>

    <!-- Bottom Navigation -->
    <div class="tabbar">
      <router-link to="/" class="tb-item" active-class="active">
        <i class="ti ti-home"></i>
        <span>الرئيسية</span>
      </router-link>
      <router-link to="/categories" class="tb-item" active-class="active">
        <i class="ti ti-category"></i>
        <span>الأقسام</span>
      </router-link>
      <router-link to="/search" class="tb-item" active-class="active">
        <i class="ti ti-search"></i>
        <span>البحث</span>
      </router-link>
      <router-link to="/cart" class="tb-item" active-class="active">
        <div class="tb-badge">
          <i class="ti ti-shopping-cart"></i>
          <div class="tb-badge-dot"></div>
        </div>
        <span>السلة</span>
      </router-link>
      <router-link to="/profile" class="tb-item" active-class="active">
        <i class="ti ti-user"></i>
        <span>حسابي</span>
      </router-link>
    </div>
  </div>
</template>

<script setup>
// App Layout logic
</script>
