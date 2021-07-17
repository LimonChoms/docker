#!/bin/sh

set -e
echo "---Start Nextcloud Cron---"
/usr/sbin/crond
echo "---  Start Nextcloud  ---"
php-fpm

exec "$@"
