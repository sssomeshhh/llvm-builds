FROM ubuntu:24.04 AS ubuntu

FROM ubuntu AS base

# install dependencies
ENV DEBIAN_FRONTEND='noninteractive'
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        curl git gzip lz4 tar xz-utils \
        binutils ccache cmake make ninja-build \
        libedit-dev libstdc++-14-dev zlib1g-dev \
        python3 python3-pip python3-venv && \
    rm -rf /var/lib/apt/lists/*

# set llvm version
ENV LLVM_VERSION=18.1.7

# setup source
WORKDIR /root
RUN mkdir llvm && \
    cd llvm && \
    mkdir bd bd/llvm id id/llvm && \
    curl -LO "https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-$LLVM_VERSION.tar.gz" && \
    tar -xzf llvmorg-$LLVM_VERSION.tar.gz && \
    rm -rf llvmorg-$LLVM_VERSION.tar.gz && \
    mv llvm-project-llvmorg-$LLVM_VERSION sd -v
