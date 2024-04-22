ARG BASE_IMAGE

FROM $BASE_IMAGE AS base

FROM base AS clean

# setup clang
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        clang-14 lld-14 lldb-14 libc++-dev libc++abi-dev && \
    rm -rf /var/lib/apt/lists/*
ENV CC="/usr/bin/clang-14"
ENV CXX="/usr/bin/clang++-14"
