FROM ubuntu:jammy as llvm-build

# install dependencies
ENV DEBIAN_FRONTEND='noninteractive'
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y binutils curl git nano && \
    apt-get install -y ccache cmake make ninja-build && \
    apt-get install -y clang-14 lld-14 lldb-14 && \
    apt-get install -y libc++-dev libc++abi-dev && \
    apt-get install -y gzip lz4 tar xz-utils zlib1g-dev

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
    -DCMAKE_C_COMPILER="/usr/bin/clang-14" \
    -DCMAKE_CXX_COMPILER="/usr/bin/clang++-14" \
    -DCMAKE_CXX_FLAGS="-stdlib=libc++" \
    -DCMAKE_INSTALL_PREFIX=$ID \
  # llvm opt-var
    -DLLVM_ENABLE_LIBCXX=ON \
    -DLLVM_ENABLE_LTO="Full" \
    -DLLVM_ENABLE_MODULES=ON \
    -DLLVM_ENABLE_PROJECTS="all" \
    -DLLVM_ENABLE_RUNTIMES="all" \
    -DLLVM_PARALLEL_COMPILE_JOBS=$(nproc) \
    -DLLVM_PARALLEL_LINK_JOBS=1 \
    -DLLVM_STATIC_LINK_CXX_STDLIB=ON \
    -DLLVM_TARGETS_TO_BUILD="all" \
    -DLLVM_USE_LINKER="lld"

RUN cmake --build $BD
RUN cmake --install $BD
