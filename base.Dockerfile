FROM ubuntu:jammy as base

# install dependencies
ENV DEBIAN_FRONTEND='noninteractive'
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        curl git nano \
        gzip lz4 tar xz-utils zlib1g-dev \
        ccache cmake make ninja-build \
        binutils libedit-dev libstdc++-12-dev \
        python3 python3-pip python3-venv

# set args
ARG LLVM_VERSION_TAG

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
    git checkout llvmorg-$LLVM_VERSION_TAG
