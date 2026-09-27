<template>
  <section class="sblock">
    <div class="install">
      <span class="install-bic" aria-hidden="true"><i class="ti ti-tools"></i></span>
      <div class="install-copy">
        <div class="install-kicker">{{ __('certified_service') }}</div>
        <h3>{{ section.data?.title || __('wizard_cta_title') }}</h3>
        <p>{{ section.data?.subtitle || __('wizard_cta_sub') }}</p>
        <div class="install-points">
          <span class="install-p" v-for="k in ['wizard_point_1', 'wizard_point_2', 'wizard_point_3']" :key="k">
            <span class="chk"><i class="ti ti-check" aria-hidden="true"></i></span>{{ __(k) }}
          </span>
        </div>
        <router-link to="/project-wizard" class="install-btn">
          <i class="ti ti-device-cctv" aria-hidden="true"></i> {{ __('wizard_cta_button') }}
        </router-link>
      </div>
      <div class="install-art" aria-hidden="true">
        <div class="install-art-card">
          <i class="ti ti-device-cctv"></i>
          <i class="ti ti-router"></i>
          <i class="ti ti-home-shield"></i>
        </div>
        <span class="tools-badge"><i class="ti ti-tools"></i></span>
      </div>
    </div>
  </section>
</template>

<script setup>
import { __ } from '../../utils/i18n';

defineProps({ section: { type: Object, required: true } });
</script>

<style scoped>
.install {
  background: var(--surface); border: 1px solid var(--line); border-radius: 24px; padding: 24px 20px;
  display: grid; gap: 20px; align-items: center; overflow: hidden; position: relative;
}
.install::before { content: ""; position: absolute; inset-inline-end: -60px; top: -60px; width: 200px; height: 200px; border-radius: 50%; background: var(--primary-soft); pointer-events: none; }
.install-copy { position: relative; }
.install-kicker { display: inline-flex; align-items: center; gap: 8px; color: var(--primary-strong); font-size: 12.5px; font-weight: 800; margin-bottom: 6px; }
.install-kicker::before { content: ""; width: 22px; height: 3px; border-radius: 3px; background: var(--primary); }
.install h3 { font-size: 20px; font-weight: 800; line-height: 1.35; margin: 0; color: var(--ink); }
.install p { color: var(--ink-2); font-size: 13.5px; margin: 10px 0 18px; max-width: 480px; line-height: 1.65; }
.install-points { display: flex; gap: 12px 18px; flex-wrap: wrap; margin-bottom: 20px; }
.install-p { display: flex; align-items: center; gap: 8px; font-size: 12.5px; font-weight: 700; color: var(--ink); }
.chk { width: 20px; height: 20px; border-radius: 50%; background: var(--success-bg); color: var(--success); display: grid; place-items: center; font-size: 12px; flex: none; }
.install-btn {
  display: inline-flex; align-items: center; gap: 9px; text-decoration: none;
  background: var(--primary-strong); color: var(--on-primary); font-weight: 800; font-size: 14px;
  padding: 12px 22px; border-radius: 11px; transition: background .18s, box-shadow .25s;
}
.install-btn:hover { background: var(--primary); box-shadow: 0 10px 24px -12px rgba(33,147,176,.6); }
.install-art { position: relative; display: none; justify-content: center; }
.install-art-card {
  width: 100%; max-width: 330px; aspect-ratio: 4 / 3; border-radius: 22px;
  background: linear-gradient(150deg, var(--primary-soft), var(--surface-2));
  display: flex; align-items: center; justify-content: center; gap: 22px; color: var(--primary-strong); font-size: 56px;
}
.tools-badge {
  position: absolute; bottom: 6%; inset-inline-start: 8%; width: 58px; height: 58px; border-radius: 18px;
  background: var(--primary-strong); color: #fff; display: grid; place-items: center; font-size: 26px;
  box-shadow: 0 16px 30px -14px rgba(23,115,138,.55); animation: bob 4.5s ease-in-out infinite;
}
@keyframes bob { 0%, 100% { transform: translateY(0) } 50% { transform: translateY(-13px) } }
.install-bic { display: none; }
/* Phone: dark service banner (mockup "index_1"): icon, title, one line, gold button. */
@media (max-width: 767px) {
  .install {
    display: flex; align-items: center; gap: 13px; flex-wrap: wrap; padding: 15px; border-radius: 18px; border: 0;
    background: linear-gradient(135deg, var(--deep), var(--deep-2)); color: #fff;
  }
  .install::before { background: radial-gradient(circle, rgba(255,255,255,.14), transparent 70%); }
  .install-bic {
    display: grid; place-items: center; width: 46px; height: 46px; border-radius: 14px; flex: none;
    background: rgba(255,255,255,.16); color: var(--sand); font-size: 22px; position: relative;
  }
  .install-copy { flex: 1; min-width: 0; display: flex; flex-direction: column; }
  .install-kicker, .install-points { display: none; }
  .install h3 { font-size: 14px; color: #fff !important; }
  .install p { font-size: 11px; color: var(--on-deep); margin: 2px 0 10px; }
  .install-btn { align-self: flex-start; background: var(--sand); color: var(--on-sand); font-size: 12.5px; padding: 0 16px; height: 38px; border-radius: 12px; }
  .install-btn i { display: none; }
}
@media (min-width: 992px) {
  .install { grid-template-columns: 1.15fr .85fr; padding: 36px; gap: 26px; }
  .install h3 { font-size: 26px; }
  .install-art { display: flex; }
}
</style>
