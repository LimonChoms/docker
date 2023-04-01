FROM ubuntu:22.04

USER root

RUN apt-get update -qq && apt-get upgrade -qqy && \
    apt-get install -qqy build-essential clang flex bison g++ gawk gcc-multilib g++-multilib gettext git libncurses5-dev libssl-dev \
    python3 python3-distutils rsync unzip zlib1g-dev file wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN groupmod -g 1000 users && useradd limons && usermod -u 99 limons && \
    groupmod -g 100 limons

USER limons
WORKDIR /home/limons

CMD ["/home/limons/build.sh"]
