# Dependency security — status & policy

_Last reviewed: 2026-09-26_

This file records the state of third-party dependencies (npm + Composer) and
the policy for keeping them safe in production. Re-run the audits below on every
deploy and update this file when the picture changes.

## npm

### Production runtime (`npm audit --omit=dev`)

```
found 0 vulnerabilities
```

The JavaScript that actually ships to the browser (the `dependencies` block in
`package.json`: vue, vue-router, pinia, axios, bootstrap, lodash, moment,
sanitize-html, cropperjs, jquery, etc.) has **no known advisories**.

### Dev/build-time only (`npm audit`, full tree)

```
12 vulnerabilities (5 low, 7 moderate)
```

All 12 come from the `laravel-mix` → `webpack-dev-server` → `sockjs` chain and a
few build loaders. **None of them ship to users** — they run only on a
developer machine during `npm run dev`/`watch`/`hot`. They are irrelevant to
production because:

- The server serves **pre-built** assets from `public/`. It never runs
  `webpack-dev-server`, `npm run watch`, or `npm run hot`.
- Production builds use `npm run prod` (`mix --production`), which does not
  start the dev server.

**Do not run `npm run watch`/`hot`/`dev` on the production server.** If a
future `laravel-mix` release moves off the vulnerable `webpack-dev-server`
line, upgrade to clear these. `npm audit fix` (without `--force`) is safe to
run; `--force` would upgrade `laravel-mix` to a major and can break the build,
so test it before committing.

### `puppeteer` removed

`puppeteer` (and the `screenshot` / `admin-screenshot` npm scripts that used it)
was removed from `devDependencies`. It carried the only **high** advisories in
the tree, was pure local dev tooling, and was never part of the build or the
shipped bundle. Removing it deleted ~800 transitive lockfile entries and dropped
the audit from 16 advisories (incl. 4 high) to the 12 dev-only above.

## Composer (PHP)

`composer audit` could not be re-run in this environment (the sandbox proxy
blocks packagist's advisory API — `curl error 28 ... security-advisories`), so
this section records the **last verified state** rather than a fresh result.

- In the security-hardening pass, the packages flagged by `composer audit`
  were updated: `twig/twig`, `phpoffice/phpspreadsheet`, `mtdowling/jmespath.php`,
  `guzzlehttp/*`, `laravel/framework` (to `^12.61`), `league/commonmark`,
  `symfony/*`, `aws/aws-sdk-php`, `dompdf/dompdf`, `phpseclib/phpseclib`,
  `maatwebsite/excel`, `google/protobuf`, `setasign/fpdi`.
- **On deploy**, run `composer audit` on a host that can reach packagist and
  reconcile any remaining advisory here. Deploy with `composer install --no-dev`
  so dev-only packages never land on the server.

## Deploy checklist (dependencies)

1. `composer install --no-dev --optimize-autoloader`
2. `npm ci && npm run prod` (never `watch`/`hot`/`dev` on the server)
3. `composer audit` — reconcile output against this file
4. `npm audit --omit=dev` — expect 0; investigate anything new
