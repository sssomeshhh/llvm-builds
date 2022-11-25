FROM ubuntu:jammy AS ubuntu



FROM ubuntu AS base

# print sysinfo
RUN uname --all && \
    lscpu && \
    free --human

# install dependencies
ENV DEBIAN_FRONTEND='noninteractive'
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        curl git nano \
        gzip lz4 tar xz-utils zlib1g-dev \
        ccache cmake make ninja-build \
        binutils libedit-dev libstdc++-12-dev \
        python3 python3-pip python3-venv && \
    rm -rf /var/lib/apt/lists/*

# set llvm version
ENV LLVM_VERSION=15.0.3

# setup source
WORKDIR /root
RUN mkdir llvm && \
    cd llvm && \
    mkdir bd && \
    mkdir bd/llvm && \
    mkdir id && \
    mkdir id/llvm && \
    git clone https://github.com/llvm/llvm-project.git sd && \
    cd sd && \
    git checkout llvmorg-$LLVM_VERSION
