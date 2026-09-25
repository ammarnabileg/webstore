<template>
<section>
  <h1 class="q-title">اختر الباقة المناسبة لك</h1>
  <p class="q-hint">بُنيت على إجاباتك، بمكونات حقيقية من مخزوننا.</p>

  <button v-for="pkg in packages" :key="pkg.tier" class="pkg"
          :class="{sel: a.package===pkg.tier}" @click="a.package=pkg.tier"
          :aria-pressed="a.package===pkg.tier">
    <span v-if="pkg.badge" class="pkg-badge">{{ pkg.badge }}</span>
    <div class="pkg-head">
      <span class="pkg-name">{{ pkg.title }}</span>
      <span class="pkg-price">يبدأ من ~{{ pkg.total }} د.ك <small>شاملة التركيب التقديري</small></span>
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
    <span class="pkg-name">لست متأكدًا؟ اترك الأمر لنا، وسنرشح لك الأنسب في المعاينة المجانية</span>
  </button>

  <p class="reco-note">الأسعار استرشادية وتُؤكَّد بعد معاينة المكان، والمعاينة مجانية ودون التزام. تختلف تكلفة التركيب حسب حالة المكان{{ a.condition===2 ? ' (المكان المُشطّب يحتاج إلى تمديدات خارجية عبر مجارٍ)' : '' }}. إذا رسمت مخطط المكان بالأسفل، تُضبط أعداد الكاميرات وأسعار الباقات عليه تلقائيًا.{{ a.condition===2 && a.conduits==='unsure' ? ' وإذا تبيّن في المعاينة وجود التمديدات، ينخفض السعر ولا يزيد.' : '' }}</p>

  <div class="h-sub">ملخص طلبك</div>
  <div class="sum-list">
    <div class="sum-row" v-for="s in summary" :key="s.k">
      <span class="k">{{ s.k }}</span><span class="v">{{ s.v }}</span>
    </div>
  </div>

  <div class="h-sub">مخطط المكان <span style="font-weight:400;color:var(--muted);font-size:13px;">(اختياري، ويساعدنا على تجهيز عرض أدق قبل المعاينة)</span></div>
  <div class="plan-box">
    <div class="plan-tabs">
      <button :class="{sel:planTab==='draw'}" @click="planTab='draw'">ارسمه بنفسك</button>
      <button :class="{sel:planTab==='upload'}" @click="planTab='upload'">ارفع صورة</button>
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
import FloorSketch from './FloorSketch.vue';
import PlanUpload from './PlanUpload.vue';
import LeadForm from './LeadForm.vue';

const { a, packages, summary, planTab } = inject('wizard');
</script>
