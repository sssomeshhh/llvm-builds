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
ENV LLVM_VERSION=18.1.4

# setup source
WORKDIR /root
RUN mkdir llvm && \
    cd llvm && \
    mkdir bd && \
    mkdir bd/llvm && \
    mkdir id && \
    mkdir id/llvm && \
    curl -LO "https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-$LLVM_VERSION.tar.gz" && \
    tar -xzf llvmorg-$LLVM_VERSION.tar.gz && \
    rm -rf llvmorg-$LLVM_VERSION.tar.gz && \
    mv llvm-project-llvmorg-$LLVM_VERSION sd -v
