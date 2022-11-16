ARG BASE_IMAGE_BUILD

FROM $BASE_IMAGE_BUILD as llvm-build

# install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl git nano && \
    apt-get install -y ccache clang-14 cmake make ninja-build && \
    apt-get install -y libc++-dev libc++abi-dev && \
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

# set args
ARG BD=/root/llvm/bd/llvm
ARG ID=/root/llvm/id/llvm
ARG SD=/root/llvm/sd/llvm

# build artifacts
RUN cmake \
    -S $SD \
    -B $BD \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER="/usr/bin/clang-14" \
    -DCMAKE_CXX_COMPILER="/usr/bin/clang++-14" \
    -DCMAKE_CXX_FLAGS="-stdlib=libc++" \
    -DCMAKE_INSTALL_PREFIX=$ID \
    -DLLVM_ENABLE_PROJECTS="all" \
    -DLLVM_INSTALL_UTILS=ON \
    -DLLVM_PARALLEL_COMPILE_JOBS=$(nproc) \
    -DLLVM_TARGETS_TO_BUILD="all"
RUN cmake --build $BD
RUN cmake --install $BD
