FROM jellyfin/jellyfin:latest
LABEL maintainer="limonchoms@outlook.com"

RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y fonts-noto-cjk-extra \
    && apt-get clean autoclean -y && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && groupmod -g 1000 users \
    && groupadd --gid 100 jellyfin \
    && useradd --uid 99 --gid 100 jellyfin \
    && chown -R jellyfin:jellyfin /jellyfin /config /cache

USER jellyfin
