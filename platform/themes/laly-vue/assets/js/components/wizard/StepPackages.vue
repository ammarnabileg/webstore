<template>
<section>
  <h1 class="q-title">{{ __('wiz_pkg_title') }}</h1>
  <p class="q-hint">{{ __('wiz_pkg_hint') }}</p>

  <button v-for="pkg in packages" :key="pkg.tier" class="pkg"
          :class="{sel: a.package===pkg.tier}" @click="a.package=pkg.tier"
          :aria-pressed="a.package===pkg.tier">
    <span v-if="pkg.badge" class="pkg-badge">{{ pkg.badge }}</span>
    <div class="pkg-head">
      <span class="pkg-name">{{ pkg.title }}</span>
      <span class="pkg-price">{{ __('wiz_pkg_from') }} ~{{ pkg.total }} {{ __('wiz_kwd') }} <small>{{ __('wiz_pkg_incl_install') }}</small></span>
    </div>
    <div class="pkg-outcome">{{ pkg.outcome }}</div>
    <ul class="pkg-items">
      <li v-for="it in pkg.items" :key="it.name">
        <span>{{ it.name }}</span><span>{{ it.qty > 1 ? '×' + it.qty : '' }}</span>
      </li>
    </ul>
    <div class="pkg-foot" v-if="pkg.foot">{{ pkg.foot }}</div>
  </button>

  <button class="pkg slim" :class="{sel: a.package==='advise'}" @click="a.package='advise'" :aria-pressed="a.package==='advise'">
    <span class="pkg-name">{{ __('wiz_pkg_advise') }}</span>
  </button>

  <p class="reco-note">{{ __('wiz_pkg_reco_base') }}{{ a.condition===2 ? __('wiz_pkg_reco_finished') : '' }}{{ __('wiz_pkg_reco_sketch') }}{{ a.condition===2 && a.conduits==='unsure' ? __('wiz_pkg_reco_conduits') : '' }}</p>

  <div class="h-sub">{{ __('wiz_pkg_summary') }}</div>
  <div class="sum-list">
    <div class="sum-row" v-for="s in summary" :key="s.k">
      <span class="k">{{ s.k }}</span><span class="v">{{ s.v }}</span>
    </div>
  </div>

  <div class="h-sub">{{ __('wiz_pkg_plan') }} <span style="font-weight:400;color:var(--muted);font-size:13px;">{{ __('wiz_pkg_plan_note') }}</span></div>
  <div class="plan-box">
    <div class="plan-tabs">
      <button :class="{sel:planTab==='draw'}" @click="planTab='draw'">{{ __('wiz_pkg_tab_draw') }}</button>
      <button :class="{sel:planTab==='upload'}" @click="planTab='upload'">{{ __('wiz_pkg_tab_upload') }}</button>
    </div>

    <FloorSketch v-if="planTab==='draw'" />

    <PlanUpload v-else />
  </div>

  <LeadForm />
</section>
</template>

<script setup>
// Step 5: packages, summary, optional plan and the lead form.
import { inject } from 'vue';
import { __ } from '../../utils/i18n';
import FloorSketch from './FloorSketch.vue';
import PlanUpload from './PlanUpload.vue';
import LeadForm from './LeadForm.vue';

const { a, packages, summary, planTab } = inject('wizard');
</script>
