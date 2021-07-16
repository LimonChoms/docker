#!/bin/sh

set -e
echo "---Start Nextcloud---"
php-fpm

exec "$@"
