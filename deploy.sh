#!/usr/bin/env bash
# Production deploy for brilliant-kw.com (Plesk Git, "Additional deployment actions").
#
# In Plesk, the deployment action is a single line:
#     bash /var/www/vhosts/brilliant-kw.com/httpdocs/deploy.sh
#
# What it does, in order, after Plesk has pulled the new commit:
#   1. Takes the site out of maintenance mode if an earlier deploy left it there. This script never
#      runs `artisan down`: a failed step must not leave the shop closed.
#   2. Installs PHP dependencies (no dev packages).
#   3. Runs database migrations.
#   4. Publishes Botble core/plugin assets (public/vendor/core is not in git: jQuery, admin,
#      checkout and payment JS live there) and the theme assets (public/themes/laly-vue).
#   5. Clears every cache, then rebuilds config/route/view caches. If route or view caching fails,
#      the cache is cleared instead so the site still runs (slower) and the error is in the log.
#
# Everything is also written to storage/logs/deploy-YYYY-MM-DD.log. Send that file when a deploy
# goes wrong. Uploaded media in public/storage is never touched.

set -u

APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PHP_BIN="${PHP_BIN:-/opt/plesk/php/8.4/bin/php}"
[ -x "$PHP_BIN" ] || PHP_BIN="$(command -v php)"
COMPOSER_PHAR="${COMPOSER_PHAR:-/usr/lib/plesk-9.0/composer.phar}"

cd "$APP_DIR" || exit 1
mkdir -p storage/logs
LOG="storage/logs/deploy-$(date +%F).log"
exec > >(tee -a "$LOG") 2>&1

FAILED=()
step() {
    local name="$1"; shift
    echo
    echo "==> $name"
    if "$@"; then
        echo "    ok"
        return 0
    fi
    echo "    FAILED: $name"
    FAILED+=("$name")
    return 1
}
artisan() { "$PHP_BIN" artisan "$@" --no-interaction; }
composer_install() {
    if [ -f "$COMPOSER_PHAR" ]; then
        "$PHP_BIN" "$COMPOSER_PHAR" install --no-dev --optimize-autoloader --no-interaction --no-ansi
    else
        composer install --no-dev --optimize-autoloader --no-interaction --no-ansi
    fi
}

echo "=== deploy $(date '+%F %T') commit $(git rev-parse --short HEAD 2>/dev/null || echo '?')"
echo "    php: $("$PHP_BIN" -r 'echo PHP_VERSION;')  dir: $APP_DIR"

if [ ! -f .env ]; then
    echo "FAILED: .env is missing in $APP_DIR (copy it back before deploying)."
    exit 1
fi

step "leave maintenance mode (if an old deploy left it on)" artisan up || true

if ! step "composer install" composer_install; then
    echo
    echo "Composer failed: stopping here so the old caches keep serving the site."
    echo "Most common cause: the PHP version above is lower than composer.lock needs (8.4)."
    exit 1
fi

step "migrate" artisan migrate --force
step "publish Botble assets (public/vendor/core)" artisan cms:publish:assets
step "publish theme assets" artisan cms:theme:assets:publish
step "storage link (skipped if public/storage exists)" artisan storage:link || true

step "clear caches" artisan optimize:clear
step "cache config" artisan config:cache || artisan config:clear
step "cache routes" artisan route:cache || artisan route:clear
step "cache views" artisan view:cache || artisan view:clear

# Never end in maintenance mode.
artisan up >/dev/null 2>&1 || true

echo
if [ ${#FAILED[@]} -eq 0 ]; then
    echo "=== deploy finished OK"
    echo "    Next: purge the Cloudflare cache, then hard-refresh the site."
    exit 0
fi
echo "=== deploy finished with failures:"
printf '    - %s\n' "${FAILED[@]}"
echo "    Full log: $APP_DIR/$LOG"
exit 1
