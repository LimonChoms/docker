FROM php:fpm-alpine
LABEL maintainer="limonchoms@outlook.com"

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gd zip pdo_mysql pdo_pgsql bz2 intl ldap imap bcmath gmp exif apcu memcached redis imagick pcntl opcache
    
COPY php.ini $PHP_INI_DIR/
COPY www.conf /usr/local/etc/php-fpm.d/
COPY entrypoint.sh /

RUN apk add --no-cache tzdata p7zip unrar \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" >  /etc/timezone \
    && rm -rf /var/cache/apk/* \
    && rm /var/spool/cron/crontabs/root \
    && echo '*/5 * * * * php -f /var/www/html/cron.php' > /var/spool/cron/crontabs/www-data \
    && sed -i 's/405:100/999:1000/g' /etc/passwd && sed -i 's/82:82/99:100/g' /etc/passwd \
    && sed -i 's/100/1000/g' /etc/group && sed -i 's/82/100/g' /etc/group \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
