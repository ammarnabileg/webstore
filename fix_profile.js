const fs = require('fs');
const path = 'c:/wamp64/www/platform/themes/laly-vue/assets/js/pages/Profile.vue';
let content = fs.readFileSync(path, 'utf8');

// The string currently looks like: <i class="ti ti-chevron-left" :class="{ 'ti-chevron-right': !window?.BotbleData?.is_rtl } pl-arrow"></i>
content = content.replace(/class="ti ti-chevron-left" :class="\{ 'ti-chevron-right': !window\?.BotbleData\?.is_rtl \} pl-arrow"/g, 'class="ti ti-chevron-left pl-arrow" :class="{ \'ti-chevron-right\': !window?.BotbleData?.is_rtl }"');

fs.writeFileSync(path, content, 'utf8');
console.log('Fixed Profile.vue syntax');
