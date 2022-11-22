ARG BASE_IMAGE
FROM $BASE_IMAGE AS base



ARG CHAIN_IMAGE
FROM $CHAIN_IMAGE AS chain



FROM base AS stage

# setup clang
COPY --from=chain /root/llvm/id/llvm /root/.llvm
ENV CC="/root/.llvm/bin/clang"
ENV CXX="/root/.llvm/bin/clang++"
