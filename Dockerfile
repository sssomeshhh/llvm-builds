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

# setup variables
ARG BD=/root/llvm/bd/llvm
ARG ID=/root/llvm/id/llvm
ENV SD=/root/llvm/sd/llvm

# build source
RUN cmake \
    -S $SD \
    -B $BD \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER="/usr/bin/clang-14" \
    -DCMAKE_CXX_COMPILER="/usr/bin/clang++-14" \
    -DCMAKE_CXX_FLAGS="-stdlib=libc++" \
    -DCMAKE_INSTALL_PREFIX=$ID \
    -DLLVM_DEFAULT_TARGET_TRIPLE="x86_64-linux-gnu" \
    -DLLVM_ENABLE_PROJECTS="all" \
    -DLLVM_ENABLE_RUNTIMES="all" \
    -DLLVM_INSTALL_UTILS=ON \
    -DLLVM_TARGETS_TO_BUILD="all"
RUN cmake \
    --build \
    $BD \
    -- \
    -j $(nproc)
RUN cmake \
    --install \
    $BD
