FROM ubuntu:latest

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        autoconf \
        curl \
        device-tree-compiler \
        gcc \
        gcc-riscv64-linux-gnu \
        git \
        libreadline6-dev \
        libsdl2-dev \
        make \
        tmux \
        wget \
        zlib1g-dev &&\
    apt-get upgrade -y && \
    apt-get clean

# Build NEMU
RUN git config --global http.sslverify false &&\
    git clone https://github.com/OpenXiangShan/NEMU.git &&\
    cd NEMU &&\
    export NEMU_HOME=$(pwd) &&\
    make riscv64-xs_defconfig &&\
    make j$(grep -c ^processor /proc/cpuinfo)