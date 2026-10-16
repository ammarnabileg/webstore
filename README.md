# webstore

Laravel 12 + Botble CMS (ecommerce) store for brilliant-kw.com, with the Vue storefront theme
`platform/themes/laly-vue`.

## Deploy

Production runs from Plesk Git (manual deploy). The whole deploy is `deploy.sh` in the repo root;
the Plesk "Additional deployment actions" box holds one line:

```bash
bash /var/www/vhosts/brilliant-kw.com/httpdocs/deploy.sh
```

It installs PHP dependencies without dev packages, migrates, publishes the Botble assets
(`public/vendor/core` is not in git: jQuery, admin, checkout and payment JS) and the theme assets,
then rebuilds the config/route/view caches. It never runs `artisan down`, takes the site out of
maintenance mode if an older deploy left it there, and falls back to no cache if a cache step
fails. Each run is logged to `storage/logs/deploy-YYYY-MM-DD.log`. Override the binaries with
`PHP_BIN=... COMPOSER_PHAR=... bash deploy.sh` on another host.

The theme bundle (`platform/themes/laly-vue/public/js/app.js`) is built and committed, so the
server does not need Node. After a deploy, purge the Cloudflare cache.

Production `.env` must have `APP_DEBUG=false`, a unique `APP_KEY`, `QUEUE_CONNECTION=database`,
and `TRUSTED_PROXIES` set to the CDN / load balancer ranges when the site sits behind one.
See `.env.example` for the rest (Evolution WhatsApp API, AI, CSP).

### Cron (required)

Queued work (order WhatsApp messages, WhatsApp broadcasts, push notifications) and scheduled
notifications run from Laravel's scheduler. The scheduler also starts a short-lived queue worker
every minute, so no supervisor is needed:

```cron
* * * * * cd /path/to/webstore && php artisan schedule:run >> /dev/null 2>&1
```

Without this cron line nothing queued is ever sent. On a VPS you may run a permanent
`php artisan queue:work` under supervisor instead; the scheduled worker then just finds the
queue empty.

### Phone numbers

Phones are stored as `965XXXXXXXX`. After deploying, normalize existing rows once and review
customers that share a number:

```bash
php artisan customers:normalize-phones --dry-run   # report only
php artisan customers:normalize-phones             # rewrite + CSV in storage/app/reports
```

Nothing is merged or deleted. Add a unique index on `ec_customers.phone` only after the report
shows no duplicates.

## Tests

```bash
vendor/bin/phpunit
```
