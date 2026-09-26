// Findings collector with stable ids, JSON + Markdown output, baseline comparison.
const fs = require('fs');
const path = require('path');

const ORDER = { critical: 0, high: 1, medium: 2, low: 3, info: 4 };

class Report {
  constructor({ base, outDir, commit }) {
    this.meta = { ts: new Date().toISOString(), base, commit };
    this.outDir = outDir;
    this.findings = [];
    this.visits = [];
    fs.mkdirSync(path.join(outDir, 'screenshots'), { recursive: true });
  }

  // id must be deterministic for the same probe+route so baselines are stable.
  add({ id, severity = 'medium', category, url = '', method = 'GET', step = '', evidence = {}, recommendation = '' }) {
    if (this.findings.some((f) => f.id === id)) return; // dedupe
    this.findings.push({ id, severity, category, url, method, step, evidence, recommendation });
  }

  visit(v) { this.visits.push(v); }

  summary() {
    const s = { critical: 0, high: 0, medium: 0, low: 0, info: 0 };
    for (const f of this.findings) s[f.severity] = (s[f.severity] || 0) + 1;
    return s;
  }

  compare(baselineFile) {
    if (!baselineFile || !fs.existsSync(baselineFile)) return { newFindings: this.findings, resolved: [] };
    const base = JSON.parse(fs.readFileSync(baselineFile, 'utf8'));
    const known = new Set((base.findings || []).map((f) => f.id));
    const now = new Set(this.findings.map((f) => f.id));
    return {
      newFindings: this.findings.filter((f) => !known.has(f.id)),
      resolved: (base.findings || []).filter((f) => !now.has(f.id)),
    };
  }

  write() {
    const sorted = [...this.findings].sort((a, b) => ORDER[a.severity] - ORDER[b.severity]);
    const json = { run: this.meta, summary: this.summary(), findings: sorted, visits: this.visits.length };
    fs.writeFileSync(path.join(this.outDir, 'report.json'), JSON.stringify(json, null, 2));
    const md = [];
    md.push(`# e2e report — ${this.meta.ts}`, '', `Base: ${this.meta.base} · commit: ${this.meta.commit} · pages visited: ${this.visits.length}`, '');
    md.push('| severity | count |', '|---|---|');
    for (const k of Object.keys(ORDER)) md.push(`| ${k} | ${json.summary[k] || 0} |`);
    md.push('', '## Findings', '');
    for (const f of sorted) {
      md.push(`### [${f.severity.toUpperCase()}] ${f.id}`);
      md.push(`- category: ${f.category} · ${f.method} \`${f.url}\`${f.step ? ` · step: ${f.step}` : ''}`);
      if (f.evidence && Object.keys(f.evidence).length) md.push('- evidence: `' + JSON.stringify(f.evidence).slice(0, 400) + '`');
      if (f.recommendation) md.push(`- fix: ${f.recommendation}`);
      md.push('');
    }
    fs.writeFileSync(path.join(this.outDir, 'report.md'), md.join('\n'));
    return json;
  }
}

module.exports = { Report, ORDER };
