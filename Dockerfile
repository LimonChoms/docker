FROM nextcloud:fpm
LABEL maintainer="limonchoms@outlook.com"

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions bz2 imap gmp 

RUN sed -i 's/ main/ main contrib non-free/g' /etc/apt/sources.list \
    && apt-get update && apt-get install -y \
    supervisor unrar p7zip p7zip-full ffmpeg libmagickcore-6.q16-6-extra \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /var/log/supervisord /var/run/supervisord \
    && sed -i 's/33:33/99:100/g' /etc/passwd \
    && sed -i 's/100/1000/g' /etc/group && sed -i 's/33/100/g' /etc/group

COPY supervisord.conf /

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
