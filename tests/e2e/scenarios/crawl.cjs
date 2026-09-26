// Visit every inventory page as guest and customer, per locale/viewport/theme; run per-page checks; screenshot.
const path = require('path');
const { newContext, instrument } = require('../lib/browser.cjs');
const { resolve } = require('../lib/inventory.cjs');
const { rawKeys, placeholders, localePrefixViolations, chrome } = require('../lib/assertions.cjs');
const { login } = require('../lib/session.cjs');

async function run({ browser, base, prefixes, viewports, themes, report, accounts, outDir }) {
  for (const [locale, prefix] of Object.entries(prefixes)) {
    for (const viewport of viewports) {
      for (const theme of themes) {
        if (viewport === 'desktop' && theme === 'dark') continue; // bound runtime; dark is checked on mobile
        for (const who of ['guest', 'customer']) {
          const ctx = await newContext(browser, { viewport, locale, theme, blockExternalFor: base });
          const page = await ctx.newPage();
          const col = instrument(page);
          if (who === 'customer') {
            const r = await login(page, base, accounts.customer1, prefix);
            if (!r.ok) report.add({ id: `LOGIN-FAILED-${locale}`, severity: 'high', category: 'auth', url: `${prefix}/login`, method: 'POST', evidence: { status: r.loginStatus }, recommendation: 'Customer login is broken for the seeded account.' });
          }
          const inventory = await resolve(page, base, prefix);
          for (const e of inventory) {
            if (e.auth === 'guest' && who === 'customer') continue;
            if (e.auth === 'customer' && who === 'guest') continue;
            const url = `${base}${prefix}${e.path}`;
            const tag = `${e.id}·${who}·${locale}·${viewport}·${theme}`;
            const before = { pe: col.pageErrors.length, ce: col.consoleErrors.length, se: col.serverErrors.length };
            let status = 0;
            try {
              const resp = await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 30000 });
              status = resp ? resp.status() : 0;
              await page.waitForTimeout(1200);
            } catch (err) {
              report.add({ id: `NAV-FAIL-${e.id}-${locale}`, severity: 'medium', category: 'availability', url, evidence: { error: err.message.slice(0, 200) } });
              continue;
            }
            const expected = e.expectStatus || 200;
            if (status !== expected && !(e.optional && status === 404)) {
              report.add({ id: `HTTP-${e.id}-${who}-${locale}`, severity: status >= 500 ? 'high' : 'medium', category: 'availability', url, evidence: { status, expected } });
            }
            const text = await page.evaluate(() => document.body.innerText || '');
            const rk = rawKeys(text);
            if (rk.length) report.add({ id: `RAW-KEY-${e.id}-${locale}`, severity: 'low', category: 'i18n', url, evidence: { keys: rk.slice(0, 10) }, recommendation: 'Translate / correct the key so it never renders raw.' });
            const ph = placeholders(text);
            if (ph.length) report.add({ id: `PLACEHOLDER-${e.id}-${locale}`, severity: 'low', category: 'content', url, evidence: { hits: ph } });
            const lp = await localePrefixViolations(page, prefix);
            if (lp.length) report.add({ id: `LOCALE-PREFIX-${e.id}`, severity: 'medium', category: 'i18n', url, evidence: { links: lp }, recommendation: 'Build links with the locale prefix (services/api.js localePrefix / router-link).' });
            const ch = await chrome(page);
            if (e.kind === 'spa' && status === expected && !ch.spa) report.add({ id: `NO-SPA-CHROME-${e.id}-${locale}`, severity: 'medium', category: 'ux', url, evidence: ch, recommendation: 'Page should mount the SPA (view override with #app or spaRoutes entry).' });
            if (e.kind === 'blade' && status === 200 && !ch.spa && !ch.bladeChrome) report.add({ id: `STRANDED-${e.id}`, severity: 'medium', category: 'ux', url, evidence: ch, recommendation: 'Render the theme chrome (header/tab bar) around Blade fallback pages.' });
            if (ch.lang && !ch.lang.toLowerCase().startsWith(locale)) report.add({ id: `HTML-LANG-${e.id}-${locale}`, severity: 'low', category: 'i18n', url, evidence: { lang: ch.lang, expected: locale } });
            if (locale === 'ar' && ch.dir && ch.dir !== 'rtl') report.add({ id: `HTML-DIR-${e.id}`, severity: 'low', category: 'i18n', url, evidence: { dir: ch.dir } });
            const newPE = col.pageErrors.slice(before.pe), newCE = col.consoleErrors.slice(before.ce), newSE = col.serverErrors.slice(before.se);
            if (newPE.length) report.add({ id: `PAGE-ERROR-${e.id}-${locale}-${viewport}`, severity: 'medium', category: 'js', url, evidence: { errors: newPE.slice(0, 3) } });
            if (newCE.length) report.add({ id: `CONSOLE-ERROR-${e.id}-${locale}-${viewport}`, severity: 'low', category: 'js', url, evidence: { errors: newCE.slice(0, 3) } });
            if (newSE.length) report.add({ id: `SERVER-5XX-${e.id}-${locale}`, severity: 'high', category: 'server', url, evidence: { responses: newSE.slice(0, 3) } });
            await page.screenshot({ path: path.join(outDir, 'screenshots', `${tag}.png`), fullPage: false }).catch(() => {});
            report.visit({ tag, url, status });
          }
          await ctx.close();
        }
      }
    }
  }
}

module.exports = { run };
