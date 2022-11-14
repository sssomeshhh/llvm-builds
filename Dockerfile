FROM ubuntu:jammy as llvm-build

# update image
RUN apt-get update
RUN apt-get upgrade -y

# install dependencies
RUN apt-get install -y curl gzip tar xz-utils zlib1g-dev
RUN apt-get install -y ccache clang-14 cmake make ninja-build
RUN apt-get install -y python3 python3-pip python3-venv

# change directory
WORKDIR /root

# download source
ENV LLVM_TAGV=15.0.3
RUN curl -L -o llvm.tgz https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-$LLVM_TAGV.tar.gz
RUN tar xvf llvm.tgz

# change directory
WORKDIR /root/llvm-project-llvmorg-$LLVM_TAGV
