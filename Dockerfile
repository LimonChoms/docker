FROM php:fpm
LABEL maintainer="limonchoms@outlook.com"

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions gd zip pdo_mysql pdo_pgsql bz2 intl ldap imap bcmath gmp exif apcu memcached redis imagick pcntl opcache

RUN sed -i 's/ main/ main contrib non-free/g' /etc/apt/sources.list \
    && apt-get update && apt-get install -y \
    supervisor unrar p7zip p7zip-full ffmpeg rsync bzip2 busybox-static\
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/spool/cron/crontabs; \
    && echo '*/%%CRONTAB_INT%% * * * * php -f /var/www/html/cron.php' > /var/spool/cron/crontabs/www-data
    && mkdir /var/log/supervisord /var/run/supervisord \
    && sed -i 's/33:33/99:100/g' /etc/passwd \
    && sed -i 's/100/1000/g' /etc/group && sed -i 's/33/100/g' /etc/group
    
RUN { \
        echo 'opcache.enable=1'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=10000'; \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.save_comments=1'; \
        echo 'opcache.revalidate_freq=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini; \
    echo 'apc.enable_cli=1' >> /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini; \
    { \
        echo 'memory_limit=${PHP_MEMORY_LIMIT}'; \
        echo 'upload_max_filesize=${PHP_UPLOAD_LIMIT}'; \
        echo 'post_max_size=${PHP_UPLOAD_LIMIT}'; \
    } > /usr/local/etc/php/conf.d/nextcloud.ini
    
COPY supervisord.conf /

COPY *.sh /

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
