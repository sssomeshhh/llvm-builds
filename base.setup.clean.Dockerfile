ARG BASE_IMAGE

FROM $BASE_IMAGE as llvm-base

FROM llvm-base as llvm-clean

# setup clang
RUN apt-get install -y clang-14 lld-14 lldb-14 && \
    apt-get install -y libc++-dev libc++abi-dev
ENV CC="/usr/bin/clang-14"
ENV CXX="/usr/bin/clang++-14"
