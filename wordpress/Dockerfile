FROM php:fpm
LABEL maintainer="limonchoms@outlook.com"

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions exif imagick mysqli zip bcmath gd intl mcrypt ssh2 sockets opcache

RUN groupmod -g 1000 users \
    && usermod -u 99 www-data \
    && groupmod -g 100 www-data
    
COPY ./www.conf /usr/local/etc/php-fpm.d/www.conf 

COPY ./wordpress.ini /usr/local/etc/php/conf.d/wordpress.ini

USER www-data

EXPOSE 9000

WORKDIR /var/www/html

CMD ["php-fpm"]
