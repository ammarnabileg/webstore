const fs = require('fs');
const path = 'c:/wamp64/www/platform/themes/laly-vue/assets/js/pages/Categories.vue';
let content = fs.readFileSync(path, 'utf8');

content = content.replace('<div class="nbar-title">???????</div>', '<div class="nbar-title">{{ __(\'categories\') }}</div>');

fs.writeFileSync(path, content, 'utf8');
console.log('Categories.vue updated');
