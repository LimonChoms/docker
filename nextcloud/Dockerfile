FROM php:8.1-fpm
LABEL maintainer="limonchoms@outlook.com"

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions gd zip pdo_mysql pdo_pgsql bz2 intl ldap imap bcmath gmp exif apcu memcached redis imagick pcntl opcache sysvsem

COPY www.conf /usr/local/etc/php-fpm.d/www.conf
    
COPY nextcloud.ini /usr/local/etc/php/conf.d/nextcloud.ini

USER www-data

EXPOSE 9000

WORKDIR /var/www/html

CMD ["php-fpm"]
