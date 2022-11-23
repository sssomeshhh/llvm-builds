ARG BASE_IMAGE
ARG CHAIN_IMAGE

FROM $BASE_IMAGE AS base



FROM $CHAIN_IMAGE AS chain



FROM base AS stage

# setup clang
COPY --from=chain /root/llvm/id/llvm /root/.llvm
ENV CC="/root/.llvm/bin/clang"
ENV CXX="/root/.llvm/bin/clang++"
