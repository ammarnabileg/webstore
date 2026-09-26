# webstore

Laravel 12 + Botble CMS (ecommerce) store for brilliant-kw.com, with the Vue storefront theme
`platform/themes/laly-vue`.

## Deploy

```bash
composer install --no-dev --optimize-autoloader
php artisan migrate --force
php artisan config:cache && php artisan route:cache && php artisan view:cache
npm ci && npm run prod --theme=laly-vue
```

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
