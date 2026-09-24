const fs = require('fs');
const path = 'c:/wamp64/www/platform/themes/laly-vue/assets/sass/app.scss';
let content = fs.readFileSync(path, 'utf8');

const deletedCode = 
  /* Hide mobile elements */
  .tabbar, .nbar {
    display: none !important;
  }

  /* Reset Mobile Page Wrappers */
  .page {
    height: auto !important;
    overflow: visible !important;
  }
  .scroll {
    height: auto !important;
    overflow: visible !important;
    padding-bottom: 40px !important;
    max-width: 1200px;
    margin: 0 auto;
  }

  /* App Wrapper */
  .app-wrapper {
    background-color: var(--surface);
    min-height: 100vh;
  }

  /* Desktop Header */
  .desktop-header {
    display: block;
    background: var(--bg);
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    position: sticky;
    top: 0;
    z-index: 100;
  }
  
  .dh-inner {
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 15px 20px;
  }

  .dh-logo img {
    height: 40px;
    cursor: pointer;
  }

  .dh-search {
    flex: 1;
    max-width: 400px;
    position: relative;
    margin: 0 30px;
  }

  .dh-search input {
    width: 100%;
    padding: 10px 40px 10px 15px;
    border-radius: 20px;
    border: 1px solid transparent;
    background: var(--surface);
    font-family: inherit;
    outline: none;
    color: var(--text);
  }

  .dh-search button {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    background: none;
    border: none;
    color: var(--text2);
    cursor: pointer;
  }

  .dh-nav {
    display: flex;
    gap: 20px;
  }

  .dh-nav a {
    text-decoration: none;
    color: var(--text);
    font-weight: 600;
    transition: color 0.3s;
  }

  .dh-nav a:hover, .dh-nav a.router-link-active {
    color: var(--primary);
  }

  .dh-actions {
    display: flex;
    gap: 15px;
    align-items: center;
  }

  .dh-icon {
    font-size: 24px;
    color: var(--text);
    text-decoration: none;
    position: relative;
    cursor: pointer;
  }

  .dh-badge {
    position: absolute;
    top: -5px;
    right: -10px;
    background: var(--danger);
    color: #fff;
    font-size: 11px;
    font-weight: bold;
    width: 18px;
    height: 18px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
  }
;

content = content.replace('.desktop-footer { background: var(--bg); border-top: 1px solid var(--border); padding: 40px 20px; text-align: center; color: var(--text2); margin-top: 60px; font-size: 14px; }', '.desktop-footer { background: var(--bg); border-top: 1px solid var(--border); padding: 40px 20px; text-align: center; color: var(--text2); margin-top: 60px; font-size: 14px; }\n' + deletedCode);

fs.writeFileSync(path, content, 'utf8');
console.log('Restored deleted code in app.scss');
