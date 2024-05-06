ARG BASE_IMAGE

FROM $BASE_IMAGE AS base

FROM base AS clean

# setup clang
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        clang-16 lld-16 lldb-16 libc++-dev libc++abi-dev && \
    rm -rf /var/lib/apt/lists/*
ENV CC="/usr/bin/clang-16"
ENV CXX="/usr/bin/clang++-16"
