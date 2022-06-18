FROM php:8.0-fpm
LABEL maintainer="limonchoms@outlook.com"

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions gd zip pdo_mysql pdo_pgsql bz2 intl ldap imap bcmath gmp exif apcu memcached redis imagick pcntl opcache rar 

RUN groupmod -g 1000 users \
    && usermod -u 99 www-data \
    && groupmod -g 100 www-data 
    
COPY ./www.conf /usr/local/etc/php-fpm.d/www.conf 
    
COPY ./nextcloud.ini /usr/local/etc/php/conf.d/nextcloud.ini

CMD ["php-fpm"]
