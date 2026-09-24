<template>
  <div class="page">
    <div class="nbar">
      <div class="nbar-title">Botble Native</div>
      <div class="nbar-actions">
        <button @click="$router.push('/search')" aria-label="بحث"><i class="ti ti-search"></i></button>
        <button @click="$router.push('/cart')" aria-label="السلة"><i class="ti ti-shopping-cart"></i></button>
      </div>
    </div>
    <div class="scroll">
      <!-- Hero Banner -->
      <div class="home-hero">
        <div class="home-hero-tag">عروض الأسبوع</div>
        <div class="home-hero-title">تقنية WiFi 6E<br>أسرع شبكة</div>
        <div class="home-hero-sub">خصومات تصل لـ 33% على الراوترات</div>
        <div class="home-hero-btn" @click="$router.push('/products')">
          <span>تسوّق الآن</span>
          <i class="ti ti-arrow-left" style="font-size:14px;"></i>
        </div>
        <div class="hero-circle"></div>
        <div class="hero-circle2"></div>
      </div>

      <!-- Categories -->
      <div class="home-cats">
        <div class="sec-title" style="font-size:17px;">الأقسام</div>
        <div class="cats-scroll" v-if="!store.loading && store.categories.length">
          <div class="cat-item" v-for="cat in store.categories" :key="cat.id" @click="$router.push(`/products?category=${cat.id}`)">
            <div class="cat-circle">
               📦
            </div>
            <span class="cat-label">{{ cat.name }}</span>
          </div>
        </div>
        <div v-else-if="store.loading" style="text-align: center; color: #8e8e93; font-size: 13px; padding: 10px;">
          جاري التحميل...
        </div>
      </div>

      <!-- Featured Products -->
      <div class="home-prods">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;">
          <div class="sec-title" style="margin:0;font-size:17px;">أحدث المنتجات</div>
          <span style="font-size:14px;color:var(--primary);cursor:pointer;" @click="$router.push('/products')">عرض الكل</span>
        </div>
        
        <div v-if="store.loading" style="text-align: center; color: #8e8e93; padding: 20px;">
          جاري تحميل المنتجات...
        </div>
        
        <div class="prods-grid" v-else>
          <div class="pcard" v-for="product in store.products" :key="product.id" @click="$router.push(`/product/${product.id}`)">
            <div class="pcard-img">
              <img :src="product.image || 'https://via.placeholder.com/150'" :alt="product.name">
            </div>
            <div class="pcard-body">
              <div class="pcard-brand" v-if="product.brand_id">Brand</div>
              <div class="pcard-name">{{ product.name }}</div>
              <div class="pcard-price">
                <span v-if="product.front_sale_price !== product.price">{{ product.price_format }}</span>
                {{ product.front_sale_price_format || product.price_format || product.price }}
              </div>
              <button class="pcard-add" @click.stop="addToCart(product.id)">
                أضف للسلة <i class="ti ti-plus"></i>
              </button>
            </div>
          </div>
        </div>
      </div>

      <div style="height:16px;"></div>
    </div>
  </div>
</template>

<script setup>
import { onMounted } from 'vue';
import { useEcommerceStore } from '../stores/ecommerce';

const store = useEcommerceStore();

onMounted(() => {
    store.fetchCategories();
    store.fetchProducts({ per_page: 4 });
});

const addToCart = (id) => {
    console.log('Added to cart', id);
};
</script>
