const fs = require('fs');
const path = 'c:/wamp64/www/platform/themes/laly-vue/assets/sass/app.scss';
let content = fs.readFileSync(path, 'utf8');

const newRoot = 
/* Default Mobile Elements Hidden initially */
.desktop-header { display: none; }
/* ---------------------------------------------------
   RESET + BASE
--------------------------------------------------- */
*{box-sizing:border-box;margin:0;padding:0;-webkit-tap-highlight-color:transparent;}

::view-transition-group(*),
::view-transition-old(*),
::view-transition-new(*) {
  animation-duration: 0.25s;
  animation-timing-function: cubic-bezier(0.19, 1, 0.22, 1);
}

:root {
  --primary: #085f6e;
  --primary-dark: #054a57;
  --primary-light: #e0f4f7;
  --bg: #ffffff;
  --surface: #f4f8f9;
  --surface2: #eaf1f2;
  --text: #054a57;
  --text2: #4a6a70;
  --text3: #759196;
  --border: rgba(8, 95, 110, 0.15);
  --border2: rgba(8, 95, 110, 0.08);
  --success: #22c55e;
  --success-bg: #e1f5ee;
  --success-text: #1c7a4a;
  --warn: #f59e0b;
  --danger: #ff3b30;
  --stars: #ff9500;
  --r6: 6px;
  --r10: 10px;
  --r12: 12px;
  --r14: 14px;
  --r20: 20px;
  --font: -apple-system, BlinkMacSystemFont, 'SF Pro Text', 'Tajawal', sans-serif;
  --font-display: -apple-system, BlinkMacSystemFont, 'SF Pro Display', 'Tajawal', sans-serif;
}

:root[data-theme="dark"] {
  --primary: #2eb4c6;
  --primary-dark: #1e9aab;
  --primary-light: #054a57;
  --bg: #0d1f23;
  --surface: #142d33;
  --surface2: #1c3c44;
  --text: #e0f4f7;
  --text2: #a5c7cc;
  --text3: #759196;
  --border: rgba(224, 244, 247, 0.12);
  --border2: rgba(224, 244, 247, 0.08);
}
;

const bodyIdx = content.indexOf('body{');
if (bodyIdx !== -1) {
    content = newRoot + '\n' + content.substring(bodyIdx);
}

fs.writeFileSync(path, content, 'utf8');
console.log('Cleaned up variables in app.scss');
