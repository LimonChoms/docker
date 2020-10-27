FROM php:fpm-alpine
LABEL maintainer="limonchoms@outlook.com"

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gd zip pdo_mysql pdo_pgsql bz2 intl ldap imap bcmath gmp exif apcu memcached redis imagick pcntl
    
COPY php.ini "$PHP_INI_DIR/php.ini"
COPY www.conf "/usr/local/etc/php-fpm.d/www.conf"

RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" >  /etc/timezone \
    && rm -rf /var/cache/apk/*
