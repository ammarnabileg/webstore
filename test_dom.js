const jsdom = require('jsdom');
const { JSDOM } = jsdom;
const fs = require('fs');

const code = fs.readFileSync('c:/wamp64/www/public/themes/laly-vue/js/app.js', 'utf8');

const dom = new JSDOM(`<!DOCTYPE html><html><body><div id="app"></div></body></html>`, {
    runScripts: 'dangerously',
    url: 'http://localhost'
});

dom.window.onerror = function(msg, src, line, col, err) {
    console.error('Browser Error:', msg, err);
};

dom.window.eval(code);

setTimeout(() => console.log('Done'), 1000);
