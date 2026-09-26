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
      </div>

      <div class="sf-col" v-if="menu.length">
        <h4>{{ __('quick_links') }}</h4>
        <ul>
          <li v-for="item in menu" :key="item.url + item.title">
            <router-link v-if="item.internal" :to="item.url">{{ item.title }}</router-link>
            <a v-else :href="item.url" :target="item.target || '_blank'" rel="noopener">{{ item.title }}</a>
          </li>
        </ul>
      </div>

      <div class="sf-col" v-if="hotline || email || address">
        <h4>{{ __('contact_us') }}</h4>
        <ul class="sf-contact">
          <li v-if="hotline"><a :href="`tel:${hotline}`"><i class="ti ti-phone"></i> <span dir="ltr">{{ hotline }}</span></a></li>
          <li v-if="email"><a :href="`mailto:${email}`"><i class="ti ti-mail"></i> {{ email }}</a></li>
          <li v-if="address"><i class="ti ti-map-pin"></i> {{ address }}</li>
        </ul>
      </div>
    </div>

    <div class="sf-bottom">
      <div class="sf-inner sf-bottom-inner">
        <div class="sf-copy" v-html="copyright"></div>
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
const menu = footer.menu || [];

const copyright = computed(() => footer.copyright
  || `&copy; ${new Date().getFullYear()} ${siteTitle}. ${__('all_rights_reserved')}`);
</script>

<style scoped>
.site-footer {
  margin-top: 24px;
  background: var(--surface);
  border-top: 1px solid var(--line);
  color: var(--ink);
  font-size: 13px;
}
.sf-inner {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px 16px;
  display: grid;
  grid-template-columns: 1fr;
  gap: 20px;
}
.sf-logo { height: 32px; max-width: 140px; object-fit: contain; margin-bottom: 8px; }
.sf-about-text { margin: 0 0 10px; color: var(--ink-2); line-height: 1.6; }
.sf-social { display: flex; gap: 8px; flex-wrap: wrap; }
.sf-social a {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: var(--surface-2);
  color: var(--primary-strong);
  font-size: 18px;
  text-decoration: none;
}
.sf-social img { width: 18px; height: 18px; object-fit: contain; }
.sf-col h4 { font-size: 14px; font-weight: 800; margin: 0 0 10px; }
.sf-col ul { list-style: none; margin: 0; padding: 0; display: grid; gap: 8px; }
.sf-col a { color: var(--ink-2); text-decoration: none; }
.sf-col a:hover { color: var(--primary-strong); }
.sf-contact li { display: flex; align-items: center; gap: 6px; color: var(--ink-2); }
.sf-contact a { display: inline-flex; align-items: center; gap: 6px; }
.sf-bottom { border-top: 1px solid var(--line); background: var(--bg); }
.sf-bottom-inner {
  padding: 12px 16px;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: center;
  gap: 10px;
}
.sf-copy { color: var(--ink-2); font-size: 12px; }
.sf-payments { display: flex; gap: 8px; align-items: center; }
.sf-payments img { height: 24px; width: auto; object-fit: contain; background: #fff; border-radius: 4px; padding: 2px 4px; }
@media (min-width: 768px) {
  .sf-inner { grid-template-columns: 2fr 1fr 1fr; padding: 32px 16px; }
}
</style>
