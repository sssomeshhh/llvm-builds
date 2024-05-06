ARG END_IMAGE

FROM $END_IMAGE AS end

FROM ubuntu:24.04 AS ubuntu

FROM ubuntu AS push

# install dependencies
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        binutils libstdc++-14-dev && \
    rm -rf /var/lib/apt/lists/*

# copy artifacts
COPY --from=end /root/llvm/id/llvm /root/llvm
RUN /root/llvm/bin/clang --version
