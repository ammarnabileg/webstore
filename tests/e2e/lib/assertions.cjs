// Per-page checks: raw i18n keys, placeholder text, locale prefix, stranded pages, lang/dir.
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '../../..');
const I18N_FILE = path.join(ROOT, 'platform/themes/laly-vue/assets/js/utils/i18n.js');
const canaries = require('../config/canaries.json');

let dictKeys = null;
function i18nKeys() {
  if (dictKeys) return dictKeys;
  const src = fs.readFileSync(I18N_FILE, 'utf8');
  try {
    // Extract just the object literal after `translations =` by brace-matching (the file also
    // exports a `__()` function that would break new Function if included).
    const start = src.indexOf('{', src.indexOf('translations'));
    let depth = 0, end = -1;
    for (let i = start; i < src.length; i++) {
      if (src[i] === '{') depth++;
      else if (src[i] === '}') { depth--; if (depth === 0) { end = i + 1; break; } }
    }
    const literal = src.slice(start, end);
    const t = new Function(`return ${literal};`)();
    dictKeys = { all: new Set([...Object.keys(t.ar || {}), ...Object.keys(t.en || {})]), ar: t.ar || {}, en: t.en || {} };
  } catch (e) {
    const keys = [...src.matchAll(/^\s*['"]?([a-z0-9_]+)['"]?\s*:/gm)].map((m) => m[1]);
    dictKeys = { all: new Set(keys), ar: {}, en: {} };
  }
  return dictKeys;
}

// Tokens that look like snake_case keys AND exist in the dictionary → rendered raw.
function rawKeys(text) {
  const keys = i18nKeys().all;
  const found = new Set();
  for (const m of text.matchAll(/\b[a-z][a-z0-9]*(?:_[a-z0-9]+)+\b/g)) if (keys.has(m[0])) found.add(m[0]);
  for (const m of text.matchAll(/\b(?:plugins|core|packages)\/[a-z-]+::[a-z0-9_.-]+/g)) found.add(m[0]);
  return [...found];
}

function placeholders(text, ctx = {}) {
  const hits = [];
  for (const p of canaries.placeholders) {
    const re = new RegExp(p, 'i');
    if (re.test(text)) hits.push(p);
  }
  const year = new Date().getFullYear();
  if (year !== 2026 && /©\s*2026/.test(text)) hits.push('© 2026 (stale year)');
  return hits;
}

// Every same-origin link on a prefixed-locale page must carry the prefix.
async function localePrefixViolations(page, prefix) {
  if (!prefix) return [];
  return page.evaluate((pfx) => {
    const allow = ['/ajax/', '/storage/', '/themes/', '/vendor/', '/js/', '/css/', '/images/', '/api/', '/admin', '/service-worker', '/manifest', '/firebase', '/offline', '/logout', '/customer/', '/checkout/', '/payments/', '/payment/', '/currency/', '/product/', '/media/'];
    const bad = [];
    for (const a of document.querySelectorAll('a[href]')) {
      const h = a.getAttribute('href') || '';
      if (!h.startsWith('/') || h.startsWith('//')) continue;
      if (h === pfx || h.startsWith(pfx + '/') || h.startsWith(pfx + '?')) continue;
      if (allow.some((x) => h.startsWith(x))) continue;
      bad.push(h);
    }
    return [...new Set(bad)].slice(0, 20);
  }, prefix);
}

async function chrome(page) {
  return page.evaluate(() => ({
    spa: !!(document.querySelector('.tabbar') || document.querySelector('.desktop-header') || document.querySelector('#app .app-layout')),
    hasApp: !!document.querySelector('#app'),
    bladeChrome: !!document.querySelector('.blade-chrome'),
    homeLink: !!document.querySelector('a[href="/"], a[href$="/ar"], a[href$="/en"], a[href="/en/"], a.logo'),
    lang: document.documentElement.getAttribute('lang') || '',
    dir: document.documentElement.getAttribute('dir') || '',
  }));
}

module.exports = { i18nKeys, rawKeys, placeholders, localePrefixViolations, chrome };
