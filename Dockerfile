FROM php:8.0-fpm
LABEL maintainer="limonchoms@outlook.com"

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions gd zip pdo_mysql pdo_pgsql bz2 intl ldap imap bcmath gmp exif apcu memcached redis imagick pcntl opcache rar

RUN groupmod -g 1000 users \
    && usermod -u 99 www-data \
    && groupmod -g 100 www-data \
    && sed -i 's/pm.max_children = 5/pm.max_children = 200/g' /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's/pm.start_servers = 2/pm.start_servers = 10/g' /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's/pm.min_spare_servers = 1/pm.min_spare_servers = 10/g' /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's/pm.max_spare_servers = 3/pm.max_spare_servers = 50/g' /usr/local/etc/php-fpm.d/www.conf 
    
RUN { \
        echo 'opcache.enable=1'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=10000'; \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.save_comments=1'; \
        echo 'opcache.revalidate_freq=1'; \
        echo 'apc.enable_cli=1'; \
        echo 'memory_limit=1G'; \
        echo 'upload_max_filesize=10G'; \
        echo 'post_max_size=1G'; \
    } > /usr/local/etc/php/conf.d/nextcloud.ini

CMD ["php-fpm"]
