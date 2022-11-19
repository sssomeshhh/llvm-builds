ARG END_IMAGE

FROM $END_IMAGE as end

FROM ubuntu:jammy as llvm-push

# install dependencies
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        binutils libstdc++-12-dev && \
    rm -rf /var/lib/apt/lists/*

# copy artifacts
COPY --from=end /root/llvm/id/llvm /root
RUN /root/llvm/bin/clang --version
