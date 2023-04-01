FROM ubuntu:22.04

USER root

RUN apt-get update -qq && apt-get upgrade -qqy && \
    apt-get install -qqy build-essential clang flex bison g++ gawk gcc-multilib g++-multilib gettext git libncurses5-dev libssl-dev && \
    python3 python3-distutils rsync unzip zlib1g-dev file wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN usermod -u 99 users && \
    groupmod -g 100 users

USER user
WORKDIR /home/user

CMD ["/home/user/buid.sh"]
