FROM php:fpm
LABEL maintainer="limonchoms@outlook.com"

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions gd zip pdo_mysql pdo_pgsql bz2 intl ldap imap bcmath gmp exif apcu memcached redis imagick pcntl opcache rar

RUN sed -i 's/33:33/99:100/g' /etc/passwd \
    && sed -i 's/100/1000/g' /etc/group && sed -i 's/33/100/g' /etc/group \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/* 
    
RUN { \
        echo 'opcache.enable=1'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=10000'; \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.save_comments=1'; \
        echo 'opcache.revalidate_freq=1'; \
        echo 'apc.enable_cli=1'; \
        echo 'memory_limit=1G'; \
        echo 'upload_max_filesize=1G'; \
        echo 'post_max_size=1G'; \
    } > /usr/local/etc/php/conf.d/nextcloud.ini

CMD ["php-fpm"]
