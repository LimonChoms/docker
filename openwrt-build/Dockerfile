FROM ubuntu:24.04
LABEL maintainer="limonchoms@outlook.com"

RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y \
    build-essential clang flex bison g++ gawk gcc-multilib g++-multilib gettext git libncurses5-dev libssl-dev python3-setuptools rsync swig unzip zlib1g-dev file wget \
    && apt-get clean autoclean -y && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /root
