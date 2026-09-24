const fs = require('fs');
const content = fs.readFileSync('c:/wamp64/www/system-wizard-v10.html', 'utf8');

const styleMatch = content.match(/<style>([\s\S]*?)<\/style>/);
const style = styleMatch ? styleMatch[1].trim() : '';

const appMatch = content.match(/<div id="app" v-cloak>([\s\S]*?)<\/div>\s*<script/);
let template = appMatch ? appMatch[1].trim() : '';

let beforeSetup = '';
let setupBody = '';

// try to match up to the end
const sm = content.match(/<script>\s*const \{ createApp, reactive, ref, computed, nextTick \} = Vue;([\s\S]*?)createApp\(\{\s*setup\(\)\{([\s\S]*?)\}\s*\}\)\.mount\('#app'\);/);
if (sm) {
    beforeSetup = sm[1].trim();
    setupBody = sm[2].trim();
    setupBody = setupBody.substring(0, setupBody.lastIndexOf('return {')).trim();
}

// Ensure the imports are added
const imports = `import { ref, reactive, computed, nextTick, onMounted } from 'vue';
import axios from 'axios';`;

// Modify the setupBody to fetch catalog from API instead of using the hardcoded one
// The prompt says "Catalog served from real products table; prototype's hardcoded CATALOG removed"
let cleanSetupBody = setupBody.replace(/\/\/ ================= CATALOG.*?\}\;/s, `
let CATALOG = reactive({});
const loadingCatalog = ref(true);
const packages = computed(() => buildPackage(a, CATALOG));
const summary = computed(() => buildSummary(a, CATALOG));
const livePkg = computed(()=>{
  if (!packages.value || !packages.value.length) return null;
  const t = (a.package && a.package!=='advise') ? a.package : 'pro';
  return packages.value.find(p=>p.tier===t) || null;
});
`);

const vueContent = `<template>
<div class="suha-page">
  <div v-if="loadingCatalog" style="padding:50px; text-align:center;">
    جاري التحميل...
  </div>
  <template v-else>
${template}
  </template>
</div>
</template>

<script setup>
${imports}

${beforeSetup.replace(/const CATALOG = \{[\s\S]*?installPerPoint:\s*8,\s*\};/s, 'let CATALOG = {};')}

const loadingCatalog = ref(true);

${setupBody}

// fetch catalog on mounted
onMounted(async () => {
    try {
        const res = await axios.get('/ajax/vue/wizard-catalog');
        if (res.data && res.data.data) {
            CATALOG = res.data.data;
            loadingCatalog.value = false;
        }
    } catch (e) {
        console.error('Failed to load catalog', e);
        // Fallback for development if API is not ready
        alert('فشل في تحميل الإعدادات');
    }
});

// submit handler
const submitLead = async () => {
  phoneTouched.value = true;
  if(!phoneValid.value) return;
  submitting.value = true;
  try {
    const p = payload();
    const res = await axios.post('/ajax/vue/project-leads', p);
    if (res.data && res.data.success) {
      submitted.value = true;
    } else {
      alert(res.data.message || 'حدث خطأ أثناء الإرسال');
    }
  } catch(e) {
    console.error(e);
    alert('تعذر الاتصال بالسيرفر. يرجى المحاولة مرة أخرى.');
  } finally {
    submitting.value = false;
  }
};
</script>

<style scoped>
${style}

.suha-page {
  max-width:560px;margin:0 auto;min-height:100dvh;display:flex;flex-direction:column;
  font-family: var(--font-body);
  padding-bottom: 80px;
}
</style>
`;

fs.writeFileSync('c:/wamp64/www/platform/themes/laly-vue/assets/js/pages/SystemWizard.vue', vueContent, 'utf8');
console.log('Done!');
