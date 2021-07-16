FROM php:fpm
LABEL maintainer="limonchoms@outlook.com"

ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive
    
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions gd zip pdo_mysql pdo_pgsql bz2 intl ldap imap bcmath gmp exif apcu memcached redis imagick pcntl opcache
    
COPY php.ini $PHP_INI_DIR/
COPY www.conf /usr/local/etc/php-fpm.d/
COPY entrypoint.sh /

RUN ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt-get update && apt-get install -y p7zip unrar --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && rm /var/spool/cron/crontabs/root \
    && echo '*/5 * * * * php -f /var/www/html/cron.php' > /var/spool/cron/crontabs/www-data \
    && sed -i 's/405:100/999:1000/g' /etc/passwd && sed -i 's/82:82/99:100/g' /etc/passwd \
    && sed -i 's/100/1000/g' /etc/group && sed -i 's/82/100/g' /etc/group \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
