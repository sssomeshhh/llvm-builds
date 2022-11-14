FROM ubuntu:jammy as llvm-build

# update image
RUN apt-get update
RUN apt-get upgrade -y

# install dependencies
RUN apt-get install -y curl gzip tar xz-utils zlib1g-dev
RUN apt-get install -y ccache clang-14 cmake make ninja-build
RUN apt-get install -y libc++-dev libc++abi-dev
RUN apt-get install -y python3 python3-pip python3-venv

# change directory
WORKDIR /root

# download source
ARG LLVM_TAGV
RUN curl -L -o llvm.tgz https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-$LLVM_TAGV.tar.gz
RUN tar xvf llvm.tgz

# setup directories
RUN mkdir llvm && mkdir llvm/bd && mkdir llvm/bd/llvm
RUN ln -s -n -v llvm-project-llvmorg-$LLVM_TAGV llvm/sd

# setup variables
ENV SD=/root/llvm/sd/llvm
ENV BD=/root/llvm/bd/llvm
ENV CC=/usr/bin/clang-14
ENV CXX=/usr/bin/clang++-14
ENV CXXFLAGS="-stdlib=libc++"

# build source
RUN cmake \
    -S $SD \
    -B $BD \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;libc;libclc;lld;lldb;mlir;openmp" \
    -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind;compiler-rt;libc;openmp"
WORKDIR $BD
RUN cmake \
    --build \
    . \
    -- -j $(nproc)
