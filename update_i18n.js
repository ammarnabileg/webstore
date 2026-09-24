const fs = require('fs');
const path = 'c:/wamp64/www/platform/themes/laly-vue/assets/js/utils/i18n.js';
let content = fs.readFileSync(path, 'utf8');

content = content.replace('profile: \'?????\'', 'profile: \'?????\',\n        all: \'????\',\n        latest: \'??????\',\n        top_rated: \'?????? ???????\',\n        discount: \'???\',\n        no_products: \'?? ???? ?????? ??????\'');
content = content.replace('profile: \'Profile\'', 'profile: \'Profile\',\n        all: \'All\',\n        latest: \'Latest\',\n        top_rated: \'Top Rated\',\n        discount: \'Sale\',\n        no_products: \'No products available\'');

fs.writeFileSync(path, content, 'utf8');
console.log('i18n updated');
