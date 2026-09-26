#!/usr/bin/env node
// Storefront e2e + security probe runner.
//   /opt/node22/bin/node tests/e2e/run.cjs --base=http://127.0.0.1:8099 [--only=crawl,actions,checkout,wizard,security,lint]
//     [--locale=ar,en] [--viewport=mobile,desktop] [--theme=light,dark] [--compare=tests/e2e/config/baseline.json]
//     [--fail-on=high|medium] [--skip-seed] [--out=storage/e2e/<ts>]
const path = require('path');
const fs = require('fs');
const { execSync } = require('child_process');
const { launch } = require('./lib/browser.cjs');
const { Report, ORDER } = require('./lib/report.cjs');
const db = require('./lib/db.cjs');
const accounts = require('./config/accounts.json');

const ROOT = path.resolve(__dirname, '../..');
const args = Object.fromEntries(process.argv.slice(2).map((a) => { const [k, v] = a.replace(/^--/, '').split('='); return [k, v === undefined ? true : v]; }));
const list = (v, d) => (typeof v === 'string' ? v.split(',') : d);

(async () => {
  const base = (args.base || 'http://127.0.0.1:8099').replace(/\/$/, '');
  const only = list(args.only, ['lint', 'crawl', 'actions', 'checkout', 'wizard', 'security']);
  const locales = list(args.locale, ['ar', 'en']);
  const viewports = list(args.viewport, ['mobile', 'desktop']);
  const themes = list(args.theme, ['light', 'dark']);
  const ts = new Date().toISOString().replace(/[:.]/g, '-');
  const outDir = path.resolve(ROOT, args.out || `storage/e2e/${ts}`);
  let commit = 'unknown'; try { commit = execSync('git rev-parse --short HEAD', { cwd: ROOT }).toString().trim(); } catch {}
  const report = new Report({ base, outDir, commit });

  if (!args['skip-seed']) { console.log('[seed]'); console.log(db.seed()); }

  // Locale prefixes: default locale is unprefixed; others live under /<code>.
  const prefixes = {};
  for (const l of locales) {
    if (l === 'ar') { prefixes[l] = ''; continue; }
    try { const r = await fetch(`${base}/${l}`, { redirect: 'manual' }); prefixes[l] = r.status === 200 ? `/${l}` : null; } catch { prefixes[l] = null; }
    if (prefixes[l] === null) { console.log(`[warn] locale ${l} not available at ${base}/${l} — skipping`); delete prefixes[l]; }
  }

  let browser = await launch();
  const ctx = { browser, base, prefixes, viewports, themes, report, accounts, db, outDir, ROOT };
  const logStart = db.logSize();

  const scenarios = {
    lint: './scenarios/i18n-lint.cjs',
    crawl: './scenarios/crawl.cjs',
    actions: './scenarios/actions.cjs',
    checkout: './scenarios/checkout-cod.cjs',
    wizard: './scenarios/wizard-parity.cjs',
    security: './scenarios/security/index.cjs',
  };
  for (const name of only) {
    if (!scenarios[name]) { console.log(`[skip] unknown scenario ${name}`); continue; }
    console.log(`\n[scenario] ${name}`);
    const t0 = Date.now();
    // Fresh browser per scenario: Chromium can crash mid-run over the agent proxy, and a fresh
    // instance keeps the remaining scenarios — especially the security probes — running.
    try { if (browser.isConnected()) await browser.close(); } catch {}
    browser = await launch(); ctx.browser = browser;
    try { await require(scenarios[name]).run(ctx); }
    catch (e) { console.error(`[scenario:${name}] crashed:`, e.message); report.add({ id: `RUNNER-CRASH-${name.toUpperCase()}`, severity: 'info', category: 'runner', step: name, evidence: { error: String(e.message).slice(0, 300) } }); }
    console.log(`[scenario] ${name} done in ${Math.round((Date.now() - t0) / 1000)}s`);
  }
  await browser.close();

  // Any new ERROR lines in laravel.log during the run are evidence of server-side faults.
  const logDelta = db.logSince(logStart);
  const errLines = logDelta.split('\n').filter((l) => /\.ERROR:|\.CRITICAL:/.test(l));
  if (errLines.length) report.add({ id: 'SERVER-LOG-ERRORS', severity: 'medium', category: 'server', evidence: { count: errLines.length, sample: errLines.slice(0, 5).map((l) => l.slice(0, 200)) }, recommendation: 'Inspect storage/logs/laravel.log for the stack traces.' });
  fs.writeFileSync(path.join(outDir, 'laravel.log.delta'), logDelta);

  const json = report.write();
  const cmp = report.compare(args.compare ? path.resolve(ROOT, args.compare) : null);
  console.log('\n=== SUMMARY ===', JSON.stringify(json.summary));
  console.log(`report: ${path.relative(ROOT, outDir)}/report.md`);
  if (args.compare) console.log(`new vs baseline: ${cmp.newFindings.length}, resolved: ${cmp.resolved.length}`);
  const failOn = ORDER[args['fail-on'] || 'high'];
  const gate = (args.compare ? cmp.newFindings : json.findings).filter((f) => ORDER[f.severity] <= failOn);
  process.exit(gate.length ? 1 : 0);
})();
