const fs = require('fs');
const path = 'c:/wamp64/www/platform/themes/laly-vue/assets/js/utils/i18n.js';
let content = fs.readFileSync(path, 'utf8');

content = content.replace('profile: \'?????\',', 'profile: \'?????\',\n        cart_empty_sub: \'?? ??? ?????? ?? ?????? ??? ????? ???.\',\n        quantity: \'??????:\',\n        sub_total: \'??????? ??????\',\n        tax: \'???????\',');
content = content.replace('profile: \'Profile\',', 'profile: \'Profile\',\n        cart_empty_sub: \'You have not added any products to your cart yet.\',\n        quantity: \'Quantity:\',\n        sub_total: \'Subtotal\',\n        tax: \'Tax\',');

fs.writeFileSync(path, content, 'utf8');
console.log('i18n updated');
