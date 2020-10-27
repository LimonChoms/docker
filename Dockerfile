FROM php:fpm-alpine
LABEL maintainer="limonchoms@outlook.com"

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gd zip pdo_mysql pdo_pgsql bz2 intl ldap imap bcmath gmp exif apcu memcached redis imagick pcntl opcache
    
COPY php.ini "$PHP_INI_DIR/php.ini"
COPY www.conf "/usr/local/etc/php-fpm.d/www.conf"

RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" >  /etc/timezone \
    && rm -rf /var/cache/apk/* \
    && echo '*/5 * * * * php -f /var/www/html/cron.php' > /var/spool/cron/crontabs/www-data \
    && sed -i 's/405:100/999:999/g' /etc/passwd && sed -i 's/82:82/99:100/g' /etc/passwd

CMD ["php-fpm"]
