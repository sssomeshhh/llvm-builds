########################################################################################################################
FROM ubuntu:jammy AS ubuntu
########################################################################################################################
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
ENV LLVM_VERSION=0.0.0
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
########################################################################################################################
FROM base AS chain
# setup clang
COPY --from=stage /root/llvm/id/llvm /root/.llvm
ENV CC="/root/.llvm/bin/clang"
ENV CXX="/root/.llvm/bin/clang++"
########################################################################################################################
FROM base AS clean
# setup clang
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        clang-14 lld-14 lldb-14 \
        libc++-dev libc++abi-dev && \
    rm -rf /var/lib/apt/lists/*
ENV CC="/usr/bin/clang-14"
ENV CXX="/usr/bin/clang++-14"
########################################################################################################################
FROM stage AS end
########################################################################################################################
FROM end AS pack
# set args
ARG X
# pack artifacts
RUN cd /root/llvm && \
    du -sh $X"d" && \
    tar -cf $X"t" $X"d" && \
    rm -rf $X"d" && \
    ls -hls $X"t" && \
    xz -z9 $X"t" && \
    rm -rf $X"t" && \
    ls -hls $X"t".xz
########################################################################################################################
FROM ubuntu AS push
# install dependencies
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        binutils libstdc++-12-dev && \
    rm -rf /var/lib/apt/lists/*
# copy artifacts
COPY --from=end /root/llvm/id/llvm /root/llvm
RUN /root/llvm/bin/clang --version
########################################################################################################################
FROM setup AS stage
# build install
COPY build-install.sh .
RUN ./build-install.sh
########################################################################################################################
