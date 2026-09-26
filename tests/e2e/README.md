# Storefront e2e + security regression suite

Drives every storefront page and button end-to-end and probes each interaction for common web
vulnerabilities (CSRF, IDOR, mass-assignment, auth gates, rate limits, open redirect, XSS). It is a
**local QA tool**, not a production script — it seeds test data and drives a local server.

## Prerequisites (local host)

```bash
# 1. MariaDB (data dir already populated as `webstore`)
mariadbd-safe --user=mysql &
until mysqladmin --socket=/run/mysqld/mysqld.sock ping >/dev/null 2>&1; do sleep 1; done

# 2. Migrate + built assets (rebuild only if theme JS/Vue changed)
php artisan migrate --force
# npm ci && npm run prod --theme=laly-vue

# 3. Serve
php artisan serve --host=127.0.0.1 --port=8099
```

Playwright is installed globally on this host; the suite requires it by absolute path
(`/opt/node22/lib/node_modules/playwright`, override with `PLAYWRIGHT_PATH`). Chromium at
`/opt/pw-browsers` is auto-detected.

## Run

```bash
/opt/node22/bin/node tests/e2e/run.cjs --base=http://127.0.0.1:8099
```

Options: `--only=lint,crawl,actions,checkout,wizard,security` · `--locale=ar,en` ·
`--viewport=mobile,desktop` · `--theme=light,dark` · `--skip-seed` ·
`--compare=tests/e2e/config/baseline.json` (fail only on findings not in the baseline) ·
`--fail-on=high|medium` · `--out=storage/e2e/<name>`.

Fixtures (`fixtures/seed.php`, idempotent, LOCAL ONLY) create: languages ar(default)+en, two
customers (`customer_1/2@example.com` / `12345678`), coupon `E2E10`, a CMS page, and a variable
product `e2e-variable`.

## Output

`storage/e2e/<timestamp>/report.json` (stable finding ids), `report.md`, `screenshots/`, and
`laravel.log.delta`. Exit code is non-zero when a gating finding is present.

## Baseline workflow

1. First run produces the pre-fix findings — copy `report.json` to `config/baseline.json`
   (this is the audit artefact of the store's state before build-out).
2. After each fix, run with `--compare=config/baseline.json`; the run is green when no *new*
   findings appear. Remove ids from the baseline as their fixes land, in the same commit.

Accounts in `config/accounts.json` are local-only and never valid on production.
