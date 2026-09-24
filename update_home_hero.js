const fs = require('fs');
const path = 'c:/wamp64/www/platform/themes/laly-vue/assets/js/pages/Home.vue';
let content = fs.readFileSync(path, 'utf8');

const newHero = 
      <!-- Dynamic Hero Banners -->
      <div class="hero-scroll-container" v-if="homeSliders && homeSliders.length">
        <div 
          class="home-hero dynamic-hero" 
          v-for="slider in homeSliders" 
          :key="slider.id"
          :style="{ backgroundImage: slider.image ? 'url(' + slider.image + ')' : '' }"
          @click="slider.link ? window.location.href = slider.link : null"
        >
          <div class="hero-overlay" v-if="slider.title || slider.description">
            <div class="home-hero-title" v-if="slider.title">{{ slider.title }}</div>
            <div class="home-hero-sub" v-if="slider.description">{{ slider.description }}</div>
          </div>
        </div>
      </div>
      
      <!-- Fallback Hero Banner -->
      <div class="home-hero" v-else>
        <div class="home-hero-tag">{{ __('offers_week') || '???? ???????' }}</div>
        <div class="home-hero-title">????? WiFi 6E<br>???? ????</div>
        <div class="home-hero-sub">?????? ??? ?? 33% ??? ?????????</div>
        <div class="home-hero-btn" @click="\.push('/products')">
          <span>{{ __('shop_now') || '????? ????' }}</span>
          <i class="ti ti-arrow-left" :class="{ 'ti-arrow-right': !window?.BotbleData?.is_rtl }" style="font-size:14px;"></i>
        </div>
        <div class="hero-circle"></div>
        <div class="hero-circle2"></div>
      </div>
;

// Replace the current hero banner
const currentHeroRegex = /<!-- Hero Banner -->[\s\S]*?<div class="hero-circle2"><\/div>\s*<\/div>/;
content = content.replace(currentHeroRegex, newHero);

// Add homeSliders to script
const scriptRegex = /const siteTitle = window\.\?BotbleData\.\?site_title \|\| 'Laly';/;
const addScript = 
const siteTitle = window?.BotbleData?.site_title || 'Laly';
const homeSliders = window?.BotbleData?.homeSliders || [];
;
content = content.replace(scriptRegex, addScript);

fs.writeFileSync(path, content, 'utf8');
