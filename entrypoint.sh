#!/bin/sh

set -e

/usr/sbin/crond

php-fpm

exec "$@"
