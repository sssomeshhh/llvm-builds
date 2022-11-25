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
# set args
ARG BD=/root/llvm/bd/llvm
ARG ID=/root/llvm/id/llvm
ARG SD=/root/llvm/sd/llvm
# build artifacts
RUN cmake \
        -S $SD \
        -B $BD \
        -G Ninja \
      # cmake opt-var
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_C_COMPILER=$CC \
        -DCMAKE_CXX_COMPILER=$CXX \
        -DCMAKE_INSTALL_PREFIX=$ID \
      # llvm opt-var
        -DLLVM_ENABLE_PROJECTS="all" \
        -DLLVM_PARALLEL_COMPILE_JOBS=$(nproc) \
        -DLLVM_TARGETS_TO_BUILD="all" \
        -DLLVM_USE_LINKER="lld"
RUN cmake --build $BD
RUN cmake --install $BD
########################################################################################################################
