FROM ubuntu:jammy as llvm-base

# install dependencies
ENV DEBIAN_FRONTEND='noninteractive'
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y binutils curl git nano && \
    apt-get install -y ccache cmake make ninja-build && \
    apt-get install -y gzip lz4 tar xz-utils zlib1g-dev && \
    apt-get install -y python3 python3-pip python3-venv

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
