FROM php:8.0-fpm
LABEL maintainer="limonchoms@outlook.com"

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions gd zip pdo_mysql pdo_pgsql bz2 intl ldap imap bcmath gmp exif apcu memcached redis imagick pcntl opcache rar

RUN sed -i 's/33:33/99:100/g' /etc/passwd \
    && sed -i 's/100/1000/g' /etc/group && sed -i 's/33/100/g' /etc/group 
    
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
    } > /usr/local/etc/php/conf.d/nextcloud.ini &&\
    { \
        echo 'pm.max_children = 150'; \
        echo 'pm.start_servers = 40'; \
        echo 'pm.min_spare_servers = 40'; \
        echo 'pm.max_spare_servers = 150'; \
    } > /usr/local/etc/php-fpm.d/zz-docker.conf

CMD ["php-fpm"]
