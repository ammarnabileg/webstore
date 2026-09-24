const fs = require('fs');
const path = 'c:/wamp64/www/platform/themes/laly-vue/assets/sass/app.scss';
let content = fs.readFileSync(path, 'utf8');

content = content.replace(/background:\s*#fff;/g, 'background: var(--bg);');
content = content.replace(/color:\s*#000;/g, 'color: var(--text);');
content = content.replace(/color:\s*#333;/g, 'color: var(--text);');
content = content.replace(/color:\s*#111;/g, 'color: var(--text);');
content = content.replace(/background-color:\s*#fff;/g, 'background-color: var(--bg);');

// Add dark mode variables
const darkVars = 
:root[data-theme="dark"] {
  --bg: #121212;
  --surface: #1e1e1e;
  --surface2: #2c2c2e;
  --text: #ffffff;
  --text2: #ebebf5;
  --text3: #ebebf599;
  --border: rgba(255,255,255,.12);
  --border2: rgba(255,255,255,.08);
  --primary-light: #085f6e;
}
;
if (!content.includes('data-theme="dark"')) {
    content = content.replace(':root{', darkVars + '\n:root{');
}

fs.writeFileSync(path, content, 'utf8');
console.log('app.scss updated with dark mode variables');
