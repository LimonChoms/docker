FROM php:fpm
LABEL maintainer="limonchoms@outlook.com"
    
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions gd zip pdo_mysql pdo_pgsql bz2 intl ldap imap bcmath gmp exif apcu memcached redis imagick pcntl opcache
    
COPY php.ini $PHP_INI_DIR/
COPY www.conf /usr/local/etc/php-fpm.d/
COPY entrypoint.sh /

RUN apt-get update && apt-get install -y p7zip unrar --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i 's/33:33/99:100/g' /etc/passwd \
    && sed -i 's/100/1000/g' /etc/group && sed -i 's/33/100/g' /etc/group \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
