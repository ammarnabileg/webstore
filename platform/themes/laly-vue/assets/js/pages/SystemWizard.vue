<template>
<div class="suha-page">
  <div v-if="loadingCatalog" class="sw-state" role="status">جارٍ التحميل...</div>
  <div v-else-if="catalogError" class="sw-state" role="alert">
    <p>تعذّر تحميل بيانات الباقات.</p>
    <button class="btn btn-primary" @click="loadCatalog">حاول مرة أخرى</button>
  </div>
  <template v-else>
<!-- header -->
  <div class="top">
    <div class="brand">
      <div class="brand-mark" aria-hidden="true">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l8 4v5c0 5-3.5 8-8 9-4.5-1-8-4-8-9V7z"/><circle cx="12" cy="11" r="3"/><path d="M12 11h.01"/></svg>
      </div>
      <div>
        <div class="brand-name">اعرف نظامك</div>
        <div class="brand-sub">كاميرات · شبكات · أمان</div>
      </div>
    </div>
    <div class="signal" role="img" :aria-label="'الخطوة ' + step + ' من 5'">
      <span v-for="n in 5" :key="n" :class="{on: step >= n}"></span>
    </div>
  </div>
  <div class="step-label" v-if="!submitted">الخطوة {{ step }} من 5 — {{ stepNames[step-1] }}</div>

  <main>
    <transition name="step" mode="out-in">
      <StepPlaceType v-if="step===1 && !submitted" key="s1" />
      <StepPlaceDetails v-else-if="step===2 && !submitted" key="s2" />
      <StepNeeds v-else-if="step===3 && !submitted" key="s3" />
      <StepBudget v-else-if="step===4 && !submitted" key="s4" />
      <StepPackages v-else-if="step===5 && !submitted" key="s5" />
      <WizardDone v-else key="done" />
    </transition>
  </main>

  <SystemTray v-if="!submitted && step>1 && step<5 && trayChips.length" />
  <WizardNav v-if="!submitted" />
  </template>
</div>
</template>

<script setup>
// "اعرف نظامك" wizard page. State and logic live in composables/useWizard.js (sketch editor in
// useSketch.js) and are shared with the step components through provide/inject.
import { provide } from 'vue';
import { useWizard } from '../composables/useWizard';
import StepPlaceType from '../components/wizard/StepPlaceType.vue';
import StepPlaceDetails from '../components/wizard/StepPlaceDetails.vue';
import StepNeeds from '../components/wizard/StepNeeds.vue';
import StepBudget from '../components/wizard/StepBudget.vue';
import StepPackages from '../components/wizard/StepPackages.vue';
import WizardDone from '../components/wizard/WizardDone.vue';
import SystemTray from '../components/wizard/SystemTray.vue';
import WizardNav from '../components/wizard/WizardNav.vue';

const wizard = useWizard();
provide('wizard', wizard);

const { loadingCatalog, catalogError, loadCatalog, step, submitted, stepNames, trayChips } = wizard;
</script>

<style scoped>
/* Step markup lives in components/wizard/*; styles stay here, scoped under the page root. */
.suha-page{
  /* Storefront design tokens (--bg, --surface, --ink, --primary, --primary-soft, --line,
     --radius) are inherited from app.scss; only wizard-specific roles are mapped here. */
  --muted:var(--ink-2);
  --primary-ink:var(--primary-strong);
  --rec:var(--sale);
  --out-b:#639922; --out-bg:rgba(99,153,34,.12); --out-t:#3B6D11;
  --font-display:var(--font);
  --font-body:var(--font);
  background:var(--bg);
  color:var(--ink);
  font-family:var(--font-body);
}
.suha-page :deep(*){box-sizing:border-box;margin:0;padding:0;}
.suha-page :deep([v-cloak]){display:none;}
.suha-page{
height:100%;}

.suha-page :deep(button){font-family:inherit;cursor:pointer;}
.suha-page :deep(:focus-visible){outline:2px solid var(--primary);outline-offset:2px;border-radius:6px;}

.suha-page{
max-width:560px;margin:0 auto;min-height:100dvh;display:flex;flex-direction:column;}

/* ---------- header ---------- */
.suha-page :deep(.top){
  padding:18px 20px 10px;
  display:flex;align-items:center;justify-content:space-between;gap:12px;
}
.suha-page :deep(.brand){display:flex;align-items:center;gap:10px;}
.suha-page :deep(.brand-mark){
  width:38px;height:38px;border-radius:11px;background:var(--ink);
  display:grid;place-items:center;color:#fff;flex:none;
}
.suha-page :deep(.brand-name){font-family:var(--font-display);font-weight:600;font-size:17px;line-height:1.2;}
.suha-page :deep(.brand-sub){font-size:12px;color:var(--muted);}

.suha-page :deep(.signal){display:flex;align-items:flex-end;gap:4px;height:26px;}
.suha-page :deep(.signal span){width:8px;border-radius:3px;background:var(--line);transition:background .25s ease;}
.suha-page :deep(.signal span:nth-child(1)){height:8px;}
.suha-page :deep(.signal span:nth-child(2)){height:12px;}
.suha-page :deep(.signal span:nth-child(3)){height:16px;}
.suha-page :deep(.signal span:nth-child(4)){height:20px;}
.suha-page :deep(.signal span:nth-child(5)){height:24px;}
.suha-page :deep(.signal span.on){background:var(--primary-strong);}

.suha-page :deep(.step-label){padding:0 20px 6px;font-size:13px;color:var(--muted);}

/* ---------- main ---------- */
.suha-page :deep(main){flex:1;padding:8px 20px 150px;}
.suha-page :deep(.q-title){font-family:var(--font-display);font-weight:600;font-size:26px;line-height:1.35;margin:10px 0 4px;}
.suha-page :deep(.q-hint){color:var(--muted);font-size:14px;margin-bottom:18px;}

.suha-page :deep(.grid){display:grid;grid-template-columns:1fr 1fr;gap:10px;}
.suha-page :deep(.grid.one){grid-template-columns:1fr;}
.suha-page :deep(.opt){
  background:var(--surface);border:1.5px solid var(--line);border-radius:var(--radius);
  padding:14px 12px;display:flex;flex-direction:column;align-items:flex-start;gap:8px;
  text-align:right;font-size:15px;font-weight:500;color:var(--ink);
  transition:border-color .15s ease, background .15s ease, transform .1s ease;
  min-height:56px;
}
.suha-page :deep(.opt:active){transform:scale(.98);}
.suha-page :deep(.opt .ic){color:var(--muted);transition:color .15s ease;}
.suha-page :deep(.opt.sel){border-color:var(--primary);background:var(--primary-soft);}
.suha-page :deep(.opt.sel .ic){color:var(--primary-ink);}
.suha-page :deep(.opt .sub){font-size:12.5px;font-weight:400;color:var(--muted);}
.suha-page :deep(.opt.row){flex-direction:row;align-items:center;justify-content:flex-start;min-height:52px;}

.suha-page :deep(.seg-block){margin-bottom:18px;}
.suha-page :deep(.seg-title){font-weight:600;font-size:15px;margin-bottom:8px;}
.suha-page :deep(.seg){display:flex;gap:8px;flex-wrap:wrap;}
.suha-page :deep(.seg .opt){flex:1;min-width:64px;align-items:center;text-align:center;padding:10px 8px;min-height:44px;}

.suha-page :deep(.check){
  margin-inline-start:auto;width:20px;height:20px;border-radius:50%;
  border:1.5px solid var(--line);display:grid;place-items:center;flex:none;
  color:transparent;background:#fff;transition:all .15s ease;
}
.suha-page :deep(.opt.sel .check){background:var(--primary-strong);border-color:var(--primary);color:var(--on-primary);}

/* ---------- packages (step 5) ---------- */
.suha-page :deep(.pkg){
  background:var(--surface);border:2px solid var(--line);border-radius:var(--radius);
  padding:16px;margin-bottom:12px;width:100%;text-align:right;
  transition:border-color .15s ease, background .15s ease;position:relative;
}
.suha-page :deep(.pkg.sel){border-color:var(--primary);background:var(--primary-soft);}
.suha-page :deep(.pkg-head){display:flex;align-items:baseline;justify-content:space-between;gap:10px;flex-wrap:wrap;}
.suha-page :deep(.pkg-name){font-family:var(--font-display);font-weight:600;font-size:17px;}
.suha-page :deep(.pkg-badge){
  background:var(--ink);color:#fff;font-size:11px;border-radius:999px;
  padding:2px 10px;font-weight:600;position:absolute;top:-9px;inset-inline-start:14px;
}
.suha-page :deep(.pkg-outcome){color:var(--muted);font-size:13.5px;margin:2px 0 10px;}
.suha-page :deep(.pkg-price){font-family:var(--font-display);font-weight:700;font-size:19px;color:var(--primary-ink);white-space:nowrap;}
.suha-page :deep(.pkg-price small){font-size:12px;font-weight:400;color:var(--muted);}
.suha-page :deep(.pkg-items){list-style:none;font-size:13.5px;color:var(--ink);}
.suha-page :deep(.pkg-items li){display:flex;justify-content:space-between;gap:10px;padding:5px 0;border-top:1px dashed var(--line);}
.suha-page :deep(.pkg-items li span:last-child){color:var(--muted);white-space:nowrap;}
.suha-page :deep(.pkg-foot){font-size:12px;color:var(--muted);margin-top:8px;}
.suha-page :deep(.pkg.slim){padding:13px 16px;border-style:dashed;}
.suha-page :deep(.pkg.slim .pkg-name){font-size:15px;font-weight:500;font-family:var(--font-body);}

.suha-page :deep(.reco-note){font-size:12.5px;color:var(--muted);margin:4px 0 16px;line-height:1.7;}

/* ---------- live system tray ---------- */
.suha-page :deep(.tray){position:fixed;bottom:76px;left:0;right:0;pointer-events:none;}
.suha-page :deep(.tray-inner){max-width:560px;margin:0 auto;padding:0 20px;}
.suha-page :deep(.tray-card){
  background:var(--ink);color:#fff;border-radius:12px;
  padding:9px 14px;display:flex;align-items:center;gap:10px;
  box-shadow:0 8px 24px rgba(23,36,47,.18);overflow-x:auto;
}
.suha-page :deep(.tray-title){font-size:12px;color:#9DB2C0;flex:none;display:flex;align-items:center;gap:6px;}
.suha-page :deep(.rec-dot){width:7px;height:7px;border-radius:50%;background:var(--rec);flex:none;animation:pulse 1.6s infinite;}
@keyframes pulse{0%,100%{opacity:1}50%{opacity:.35}}
.suha-page :deep(.chip){
  background:rgba(255,255,255,.1);border:1px solid rgba(255,255,255,.16);
  border-radius:999px;padding:3px 11px;font-size:12.5px;white-space:nowrap;flex:none;
  animation:pop .25s ease;
}
@keyframes pop{from{transform:scale(.85);opacity:0}to{transform:scale(1);opacity:1}}

/* ---------- footer nav ---------- */
.suha-page :deep(.nav){position:fixed;bottom:0;left:0;right:0;background:var(--surface);border-top:1px solid var(--line);z-index:99;}
@media (max-width: 991px) {
  .suha-page :deep(.nav){ bottom: 65px; }
}
.suha-page :deep(.nav-inner){max-width:560px;margin:0 auto;padding:12px 20px;display:flex;gap:10px;align-items:center;}
.suha-page :deep(.btn){border:none;border-radius:12px;font-size:16px;font-weight:600;padding:14px 18px;transition:background .15s ease, opacity .15s ease;}
.suha-page :deep(.btn-primary){background:var(--primary-strong);color:var(--on-primary);flex:1;}
.suha-page :deep(.btn-primary:hover){background:var(--primary-ink);}
.suha-page :deep(.btn-primary:disabled){opacity:.4;cursor:not-allowed;}
.suha-page :deep(.btn-ghost){background:transparent;color:var(--muted);border:1.5px solid var(--line);}
.suha-page :deep(.skip){background:none;border:none;color:var(--muted);font-size:13.5px;text-decoration:underline;text-underline-offset:3px;margin-top:14px;}

/* ---------- summary & lead ---------- */
.suha-page :deep(.sum-list){background:var(--surface);border:1.5px solid var(--line);border-radius:var(--radius);padding:6px 16px;margin-bottom:14px;}
.suha-page :deep(.sum-row){display:flex;justify-content:space-between;gap:12px;padding:9px 0;border-bottom:1px solid var(--line);font-size:14px;}
.suha-page :deep(.sum-row:last-child){border-bottom:none;}
.suha-page :deep(.sum-row .k){color:var(--muted);flex:none;}
.suha-page :deep(.sum-row .v){font-weight:500;text-align:left;}

.suha-page :deep(.field){margin-bottom:14px;}
.suha-page :deep(.field label){display:block;font-weight:600;font-size:14.5px;margin-bottom:6px;}
.suha-page :deep(.field input){
  width:100%;border:1.5px solid var(--line);border-radius:12px;
  padding:13px 14px;font-size:16px;font-family:inherit;background:var(--surface);color:var(--ink);
}
.suha-page :deep(.field input:focus){outline:none;border-color:var(--primary);}
.suha-page :deep(.field .err){color:var(--rec);font-size:12.5px;margin-top:4px;}
.suha-page :deep(.privacy){font-size:12px;color:var(--muted);margin:4px 0 10px;}

.suha-page :deep(.wa){
  display:flex;align-items:center;justify-content:center;gap:8px;
  background:#fff;border:1.5px solid var(--line);color:var(--ink);
  border-radius:12px;padding:13px;font-size:15px;font-weight:600;width:100%;
  text-decoration:none;margin-top:10px;
}
.suha-page :deep(.wa svg){color:#25D366;}

.suha-page :deep(.h-sub){font-family:var(--font-display);font-size:17px;font-weight:600;margin:22px 0 10px;}

/* ---------- plan upload & pins (اختياري) ---------- */
.suha-page :deep(.plan-box){background:var(--surface);border:1.5px dashed var(--line);border-radius:var(--radius);padding:14px;margin-bottom:16px;}
.suha-page :deep(.plan-upload){
  display:block;text-align:center;border:1.5px solid var(--line);border-radius:12px;
  padding:16px;font-size:14.5px;font-weight:600;color:var(--primary-ink);cursor:pointer;
  background:var(--primary-soft);
}
.suha-page :deep(.plan-tools){display:flex;gap:8px;flex-wrap:wrap;margin-bottom:10px;align-items:center;}
.suha-page :deep(.tool){
  display:flex;align-items:center;gap:6px;border:1.5px solid var(--line);background:#fff;
  border-radius:999px;padding:6px 12px;font-size:13px;font-weight:600;color:var(--ink);
}
.suha-page :deep(.tool svg){width:15px;height:15px;}
.suha-page :deep(.tool.sel){border-color:var(--primary);background:var(--primary-soft);color:var(--primary-ink);}
.suha-page :deep(.tool.danger){color:var(--rec);margin-inline-start:auto;}
.suha-page :deep(.plan-stage){position:relative;border:1px solid var(--line);border-radius:10px;overflow:hidden;cursor:crosshair;}
.suha-page :deep(.plan-stage img){display:block;width:100%;user-select:none;-webkit-user-drag:none;}
.suha-page :deep(.pin){
  position:absolute;width:30px;height:30px;margin:-15px 0 0 -15px;border-radius:50%;
  display:grid;place-items:center;color:#fff;box-shadow:0 2px 8px rgba(0,0,0,.3);
  touch-action:none;cursor:grab;
}
.suha-page :deep(.pin svg){width:14px;height:14px;}
.suha-page :deep(.pin.cam){background:var(--primary-strong);}
.suha-page :deep(.pin.ap){background:var(--ink);}
.suha-page :deep(.pin.note){background:var(--rec);}
.suha-page :deep(.pin.net){background:#2F6FED;}
.suha-page :deep(.pin.tv){background:#C026D3;}
.suha-page :deep(.pin.rack){background:#B7791F;}
.suha-page :deep(.pin .x){
  position:absolute;top:-7px;left:-7px;width:16px;height:16px;border-radius:50%;
  background:#fff;color:var(--ink);border:1px solid var(--line);font-size:11px;line-height:1;
  display:grid;place-items:center;padding:0;
}
.suha-page :deep(.plan-hint){font-size:12px;color:var(--muted);margin-top:8px;line-height:1.7;}
.suha-page :deep(.live-price){
  display:flex;justify-content:space-between;align-items:center;gap:10px;
  background:var(--primary-soft);border:1px solid var(--primary);border-radius:10px;
  padding:8px 12px;font-size:13px;margin-bottom:10px;
}
.suha-page :deep(.live-price b){font-family:var(--font-display);font-size:15px;color:var(--primary-ink);white-space:nowrap;}
.suha-page :deep(.floor-tabs){display:flex;gap:6px;flex-wrap:wrap;margin-bottom:10px;}
.suha-page :deep(.floor-tabs button){
  border:1.5px solid var(--line);background:#fff;border-radius:10px;
  padding:6px 14px;font-size:13px;font-weight:600;color:var(--muted);
}
.suha-page :deep(.floor-tabs button.sel){border-color:var(--ink);background:var(--ink);color:#fff;}
.suha-page :deep(.floor-tabs .cnt){font-weight:400;font-size:11.5px;opacity:.75;}

/* ---------- sketch tool: ارسم بنفسك ---------- */
.suha-page :deep(.plan-tabs){display:flex;gap:8px;margin-bottom:12px;}
.suha-page :deep(.plan-tabs button){
  flex:1;border:1.5px solid var(--line);background:#fff;border-radius:10px;
  padding:9px;font-size:13.5px;font-weight:600;color:var(--muted);
}
.suha-page :deep(.plan-tabs button.sel){border-color:var(--primary);background:var(--primary-soft);color:var(--primary-ink);}
.suha-page :deep(.sketch-stage){
  position:relative;height:380px;border:1px solid var(--line);border-radius:10px;
  touch-action:none;cursor:crosshair;overflow:hidden;background-color:#FBFCFD;
  background-image:linear-gradient(var(--line) 1px,transparent 1px),linear-gradient(90deg,var(--line) 1px,transparent 1px);
  background-size:24px 24px;
}
.suha-page :deep(.sketch-empty){position:absolute;inset:0;display:grid;place-items:center;color:var(--muted);font-size:13.5px;pointer-events:none;text-align:center;padding:0 20px;}
.suha-page :deep(.room){position:absolute;border:2px solid var(--primary);background:rgba(14,107,98,.08);border-radius:6px;cursor:grab;touch-action:none;}
.suha-page :deep(.room.sel){border-color:var(--primary-ink);background:rgba(14,107,98,.16);box-shadow:0 0 0 2px var(--primary-soft);}
.suha-page :deep(.room.draft){border-style:dashed;pointer-events:none;background:rgba(14,107,98,.05);}
.suha-page :deep(.room .lbl){position:absolute;inset:0;display:grid;place-items:center;font-size:12px;font-weight:600;color:var(--primary-ink);pointer-events:none;padding:2px;overflow:hidden;}
.suha-page :deep(.room .x){
  position:absolute;top:-8px;left:-8px;width:16px;height:16px;border-radius:50%;
  background:#fff;color:var(--ink);border:1px solid var(--line);font-size:11px;line-height:1;
  display:grid;place-items:center;padding:0;
}
.suha-page :deep(.handle){
  position:absolute;bottom:-7px;right:-7px;width:14px;height:14px;border-radius:4px;
  background:#fff;border:2px solid var(--primary);cursor:nwse-resize;touch-action:none;
}
.suha-page :deep(.room.out){border-style:dashed;border-color:var(--out-b);background:var(--out-bg);}
.suha-page :deep(.room.out .lbl){color:var(--out-t);}
.suha-page :deep(.room.sel){border-style:solid;}
.suha-page :deep(.room.out.sel){border-color:var(--out-t);background:rgba(99,153,34,.2);}
.suha-page :deep(.label-chips){display:flex;gap:6px;flex-wrap:wrap;align-items:center;margin-bottom:10px;}
.suha-page :deep(.lchip){border:1.5px solid var(--line);background:#fff;border-radius:999px;padding:4px 11px;font-size:12.5px;font-weight:600;}
.suha-page :deep(.lchip.out){color:var(--out-t);border-color:var(--out-b);}
.suha-page :deep(.tool:disabled){opacity:.4;cursor:not-allowed;}

/* ---------- success ---------- */
.suha-page :deep(.done){text-align:center;padding:48px 10px;}
.suha-page :deep(.done-ic){width:64px;height:64px;border-radius:50%;background:var(--primary-soft);color:var(--primary-ink);display:grid;place-items:center;margin:0 auto 18px;}
.suha-page :deep(.done h2){font-family:var(--font-display);font-size:24px;margin-bottom:8px;}
.suha-page :deep(.done p){color:var(--muted);font-size:15px;max-width:34ch;margin:0 auto;}

/* ---------- transitions ---------- */
.suha-page :deep(.step-enter-active),
.suha-page :deep(.step-leave-active){transition:opacity .18s ease, transform .18s ease;}
.suha-page :deep(.step-enter-from){opacity:0;transform:translateY(14px);}
.suha-page :deep(.step-leave-to){opacity:0;transform:translateY(-10px);}
@media (prefers-reduced-motion: reduce){
  .suha-page :deep(*),
.suha-page :deep(*::before),
.suha-page :deep(*::after){animation:none!important;transition:none!important;}
}
@media (min-width:600px){
  .suha-page :deep(#app){border-inline:1px solid var(--line);background:var(--surface);}
  .suha-page :deep(main){background:var(--surface);}
}

.suha-page{
  max-width:560px;margin:0 auto;min-height:100dvh;display:flex;flex-direction:column;
  font-family: var(--font-body);
  padding-bottom: 80px;
}
@media (max-width: 991px) {
  .suha-page{ padding-bottom: 145px; }
}
.suha-page :deep(.sw-state){padding:48px 16px;text-align:center;display:grid;gap:12px;justify-items:center;color:var(--ink);}
.suha-page :deep(.hp-field){position:absolute;inset-inline-start:-9999px;width:1px;height:1px;overflow:hidden;}
.suha-page :deep(.done-estimate){font-weight:700;color:var(--primary-ink);}
</style>
