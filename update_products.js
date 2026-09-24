const fs = require('fs');
const path = 'c:/wamp64/www/platform/themes/laly-vue/assets/js/pages/Products.vue';
let content = fs.readFileSync(path, 'utf8');

content = content.replace('<div class="nbar-title">????????</div>', '<div class="nbar-title">{{ __(\'products\') }}</div>');
content = content.replace('<p>???? ????? ????????...</p>', '<p>{{ __(\'loading_products\') }}</p>');
content = content.replace('<button class="filter-btn active">????</button>', '<button class="filter-btn active">{{ __(\'all\') || \'????\' }}</button>');
content = content.replace('<button class="filter-btn">??????</button>', '<button class="filter-btn">{{ __(\'latest\') || \'??????\' }}</button>');
content = content.replace('<button class="filter-btn">?????? ???????</button>', '<button class="filter-btn">{{ __(\'top_rated\') || \'?????? ???????\' }}</button>');
content = content.replace('<div v-if="product.front_sale_price" class="pcard-badge">???</div>', '<div v-if="product.front_sale_price" class="pcard-badge">{{ __(\'discount\') || \'???\' }}</div>');
content = content.replace('??? ?????', '{{ __(\'addToCart\') }}');
content = content.replace('<p>?? ???? ?????? ??????</p>', '<p>{{ __(\'no_products\') || \'?? ???? ?????? ??????\' }}</p>');
content = content.replace('<i class="ti ti-arrow-right"></i>', '<i class="ti ti-arrow-right" :class="{ \'ti-arrow-left\': !window?.BotbleData?.is_rtl }"></i>');

fs.writeFileSync(path, content, 'utf8');
console.log('Products.vue updated');
