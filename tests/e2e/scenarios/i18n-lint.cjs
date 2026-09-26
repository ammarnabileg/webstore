// No browser: every __('key') used in the theme JS must exist in BOTH ar and en; flag drift in `__('x') || 'fallback'`.
const fs = require('fs');
const path = require('path');
const { i18nKeys } = require('../lib/assertions.cjs');

function walk(dir, out = []) {
  for (const f of fs.readdirSync(dir)) {
    const p = path.join(dir, f);
    if (fs.statSync(p).isDirectory()) walk(p, out); else if (/\.(vue|js)$/.test(f)) out.push(p);
  }
  return out;
}

async function run({ report, ROOT }) {
  const dict = i18nKeys();
  const src = path.join(ROOT, 'platform/themes/laly-vue/assets/js');
  const used = new Map();
  for (const f of walk(src)) {
    if (f.endsWith('utils/i18n.js')) continue;
    const s = fs.readFileSync(f, 'utf8');
    for (const m of s.matchAll(/__\(\s*['"]([^'"]+)['"]/g)) { if (!used.has(m[1])) used.set(m[1], []); used.get(m[1]).push(path.relative(ROOT, f)); }
  }
  let missing = 0;
  for (const [k, files] of used) {
    const inAr = Object.prototype.hasOwnProperty.call(dict.ar, k);
    const inEn = Object.prototype.hasOwnProperty.call(dict.en, k);
    // Arabic-sentence keys legitimately fall back to themselves in ar.
    const arabicKey = /[؀-ۿ]/.test(k);
    if (!inEn || (!inAr && !arabicKey)) {
      missing++;
      report.add({ id: `I18N-MISSING-${k.slice(0, 40)}`, severity: 'low', category: 'i18n', step: 'lint', evidence: { key: k, ar: inAr, en: inEn, files: files.slice(0, 3) }, recommendation: 'Add the key to utils/i18n.js for both languages.' });
    }
  }
  console.log(`[lint] keys used: ${used.size}, missing: ${missing}`);
}

module.exports = { run };
