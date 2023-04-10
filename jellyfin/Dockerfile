FROM jellyfin/jellyfin:latest
LABEL maintainer="limonchoms@outlook.com"

RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y fonts-noto-cjk-extra

RUN groupmod -g 1000 users \
    && groupadd --gid 100 jellyfin \
    && useradd --uid 99 --gid 100 jellyfin \
    && chown -R jellyfin:jellyfin /jellyfin /config /cache

USER jellyfin

EXPOSE 8096
VOLUME /cache /config
ENTRYPOINT ["./jellyfin/jellyfin", \
    "--datadir", "/config", \
    "--cachedir", "/cache", \
    "--ffmpeg", "/usr/lib/jellyfin-ffmpeg/ffmpeg"]

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 \
     CMD curl -Lk -fsS "${HEALTHCHECK_URL}" || exit 1
