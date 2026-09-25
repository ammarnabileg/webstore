<template>
<section>
  <h1 class="q-title">أخبرنا عن المكان</h1>
  <p class="q-hint">تكفي الأرقام التقريبية، لا نحتاج إلى دقة.</p>

  <div class="seg-block">
    <div class="seg-title">المساحة الإجمالية تقريباً</div>
    <div class="seg">
      <button v-for="(o,i) in areaOpts" :key="i" class="opt" :class="{sel:a.area===i}" @click="a.area=i" :aria-pressed="a.area===i">{{ o.label }}</button>
    </div>
  </div>

  <div class="seg-block">
    <div class="seg-title">عدد الأدوار</div>
    <div class="seg">
      <button v-for="(o,i) in floorOpts" :key="i" class="opt" :class="{sel:a.floors===i}" @click="a.floors=i" :aria-pressed="a.floors===i">{{ o.label }}</button>
    </div>
  </div>

  <div class="seg-block">
    <div class="seg-title">عدد المداخل الرئيسية</div>
    <div class="seg">
      <button v-for="(o,i) in entranceOpts" :key="i" class="opt" :class="{sel:a.entrances===i}" @click="a.entrances=i" :aria-pressed="a.entrances===i">{{ o.label }}</button>
    </div>
  </div>

  <div class="seg-block">
    <div class="seg-title">هل توجد مناطق خارجية؟ (حوش / كراج / سور)</div>
    <div class="seg">
      <button class="opt" :class="{sel:a.outdoor===true}" @click="a.outdoor=true" :aria-pressed="a.outdoor===true">نعم</button>
      <button class="opt" :class="{sel:a.outdoor===false}" @click="a.outdoor=false" :aria-pressed="a.outdoor===false">لا</button>
    </div>
  </div>

  <div class="seg-block">
    <div class="seg-title">حالة المكان حاليًا</div>
    <div class="seg">
      <button v-for="(o,i) in conditionOpts" :key="i" class="opt" :class="{sel:a.condition===i}" @click="a.condition=i" :aria-pressed="a.condition===i">{{ o.label }}</button>
    </div>
  </div>

  <div class="seg-block" v-if="a.condition===2">
    <div class="seg-title">هل توجد تمديدات (مواسير) جاهزة للكاميرات والشبكة؟</div>
    <div class="seg">
      <button class="opt" :class="{sel:a.conduits==='yes'}" @click="a.conduits='yes'" :aria-pressed="a.conduits==='yes'">نعم، موجودة</button>
      <button class="opt" :class="{sel:a.conduits==='no'}" @click="a.conduits='no'" :aria-pressed="a.conduits==='no'">لا</button>
      <button class="opt" :class="{sel:a.conduits==='unsure'}" @click="a.conduits='unsure'" :aria-pressed="a.conduits==='unsure'">لست متأكدًا</button>
    </div>
    <p class="plan-hint" v-if="a.conduits==='unsure'" style="margin-top:8px;">لا مشكلة، سنتأكد منها في المعاينة المجانية، وإذا كانت التمديدات موجودة ينخفض السعر.</p>
  </div>
</section>
</template>

<script setup>
// Step 2: area, floors, entrances, outdoor areas, condition.
import { inject } from 'vue';

const { a, areaOpts, floorOpts, entranceOpts, conditionOpts } = inject('wizard');
</script>
