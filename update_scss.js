const fs = require('fs');
const path = 'c:/wamp64/www/platform/themes/laly-vue/assets/sass/app.scss';
let content = fs.readFileSync(path, 'utf8');

const ltrOverrides = 
/* LTR Overrides */
[dir="ltr"] .tb-badge-dot { right: auto; left: -4px; }
[dir="ltr"] .pcard-price span { margin-right: 0; margin-left: 4px; }
[dir="ltr"] .hero-circle { right: auto; left: -20px; }
[dir="ltr"] .hero-circle2 { right: auto; left: 20px; }
[dir="ltr"] .ti-arrow-left.rtl-flip { transform: scaleX(-1); }
;

content += '\n' + ltrOverrides;

fs.writeFileSync(path, content, 'utf8');
console.log('app.scss updated');
