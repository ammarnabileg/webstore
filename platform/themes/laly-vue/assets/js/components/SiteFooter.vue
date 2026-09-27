<template>
  <footer class="site-footer">
    <div class="sf-inner">
      <div class="sf-col sf-about">
        <img v-if="siteLogo" :src="siteLogo" :alt="siteTitle" class="sf-logo">
        <p v-if="footer.about" class="sf-about-text">{{ footer.about }}</p>
        <div class="sf-social" v-if="footer.social && footer.social.length">
          <a
            v-for="s in footer.social"
            :key="s.url"
            :href="s.url"
            target="_blank"
            rel="noopener"
            :aria-label="s.name"
            :title="s.name"
          >
            <img v-if="s.image" :src="s.image" :alt="s.name">
            <i v-else :class="s.icon || 'ti ti-link'"></i>
          </a>
        </div>
        <component
          :is="footer.payment_link ? 'a' : 'div'"
          v-if="footer.payment_logos && footer.payment_logos.length"
          :href="footer.payment_link || null"
          target="_blank"
          rel="noopener"
          class="sf-payments"
          :aria-label="__('payment_methods')"
        >
          <img v-for="(logo, i) in footer.payment_logos" :key="i" :src="logo" :alt="__('payment_methods')" loading="lazy">
        </component>
      </div>

      <div class="sf-col" v-if="categories.length">
        <h4>{{ __('shop_categories') }}</h4>
        <ul>
          <li v-for="c in categories" :key="c.slug">
            <router-link :to="`/product-categories/${c.slug}`">{{ c.name }}</router-link>
          </li>
        </ul>
      </div>

      <div class="sf-col" v-if="menu.length">
        <h4>{{ __('customer_care') }}</h4>
        <ul>
          <li v-for="item in menu" :key="item.url + item.title">
            <router-link v-if="item.internal" :to="item.url">{{ item.title }}</router-link>
            <a v-else :href="item.url" :target="item.target || '_blank'" rel="noopener">{{ item.title }}</a>
          </li>
        </ul>
      </div>

      <div class="sf-col" v-if="hotline || email || address || whatsapp">
        <h4>{{ __('contact_us') }}</h4>
        <ul class="sf-contact">
          <li v-if="hotline"><a :href="`tel:${hotline}`"><i class="ti ti-phone"></i> <span dir="ltr">{{ hotline }}</span></a></li>
          <li v-if="whatsapp"><a :href="`https://wa.me/${whatsapp}`" target="_blank" rel="noopener"><i class="ti ti-brand-whatsapp"></i> <span dir="ltr">+{{ whatsapp }}</span></a></li>
          <li v-if="email"><a :href="`mailto:${email}`"><i class="ti ti-mail"></i> {{ email }}</a></li>
          <li v-if="address"><i class="ti ti-map-pin"></i> {{ address }}</li>
        </ul>
      </div>
    </div>

    <div class="sf-bottom">
      <div class="sf-inner sf-bottom-inner">
        <div class="sf-copy" v-html="copyright"></div>
      </div>
    </div>
  </footer>
</template>

<script setup>
// Footer content is dashboard-managed: Appearance → Menus (location "Footer menu"),
// Theme options → Footer / Store contact / Social links / General (copyright).
import { computed } from 'vue';
import { __ } from '../utils/i18n';

const data = window.BotbleData || {};
const footer = data.footer || {};
const siteLogo = data.logo || '';
const siteTitle = data.site_title || '';
const hotline = data.hotline || '';
const email = data.email || '';
const address = data.address || '';
const whatsapp = footer.whatsapp || '';
const menu = footer.menu || [];
const categories = footer.categories || [];

const copyright = computed(() => footer.copyright
  || `&copy; ${new Date().getFullYear()} ${siteTitle}. ${__('all_rights_reserved')}`);
</script>

<style scoped>
.site-footer {
  margin-top: 28px;
  background: var(--deep);
  color: var(--on-deep);
  font-size: 13px;
}
.sf-inner {
  max-width: 1240px;
  margin: 0 auto;
  padding: 36px 16px 28px;
  display: grid;
  grid-template-columns: 1fr;
  gap: 26px;
}
.sf-logo { height: 34px; max-width: 150px; object-fit: contain; margin-bottom: 10px; filter: brightness(0) invert(1); }
.sf-about-text { margin: 0 0 12px; line-height: 1.9; max-width: 300px; color: var(--on-deep) !important; }
.sf-social { display: flex; gap: 8px; flex-wrap: wrap; margin-bottom: 14px; }
.sf-social a {
  display: inline-flex; align-items: center; justify-content: center;
  width: 36px; height: 36px; border-radius: 50%;
  background: rgba(255,255,255,.08); border: 1px solid rgba(255,255,255,.14);
  color: #fff; font-size: 18px; text-decoration: none; transition: background .18s, color .18s;
}
.sf-social a:hover { background: var(--sand); color: var(--on-sand); }
.sf-social img { width: 18px; height: 18px; object-fit: contain; }
.sf-col h4 { color: #fff !important; font-size: 14.5px; font-weight: 800; margin: 0 0 14px; }
.sf-col ul { list-style: none; margin: 0; padding: 0; display: grid; gap: 4px; }
.sf-col a { display: inline-block; color: var(--on-deep); text-decoration: none; padding: 4px 0; transition: color .15s, padding .2s; }
.sf-col a:hover { color: #fff; padding-inline-start: 5px; }
.sf-contact li { display: flex; align-items: center; gap: 10px; }
.sf-contact a { display: inline-flex; align-items: center; gap: 10px; }
.sf-contact .ti { color: var(--sand); font-size: 16px; }
.sf-payments { display: flex; gap: 8px; align-items: center; flex-wrap: wrap; }
.sf-payments img { height: 26px; width: auto; object-fit: contain; background: #fff; border-radius: 6px; padding: 3px 6px; }
.sf-bottom { border-top: 1px solid rgba(255,255,255,.1); }
.sf-bottom-inner { padding: 14px 16px; display: flex; flex-wrap: wrap; justify-content: space-between; align-items: center; gap: 10px; }
.sf-copy { font-size: 12px; }
@media (min-width: 768px) {
  .sf-inner { grid-template-columns: 1.3fr 1fr 1fr 1.2fr; gap: 34px; padding: 52px 26px 38px; }
}
</style>
