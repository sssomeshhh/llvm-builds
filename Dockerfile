FROM ubuntu:jammy as llvm-build

# install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl git nano && \
    apt-get install -y ccache clang-14 cmake make ninja-build && \
    apt-get install -y libc++-dev libc++abi-dev && \
    apt-get install -y gzip tar xz-utils zlib1g-dev && \
    apt-get install -y python3 python3-pip python3-venv

# setup source
ARG LLVM_TAGV
WORKDIR /root
RUN mkdir llvm && \
    cd llvm && \
    mkdir bd && \
    mkdir bd/llvm && \
    mkdir id && \
    mkdir id/llvm && \
    git clone https://github.com/llvm/llvm-project.git sd && \
    cd sd && \
    git checkout llvmorg-$LLVM_TAGV
