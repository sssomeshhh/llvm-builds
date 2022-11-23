ARG BASE_IMAGE
ARG STAGE_IMAGE

FROM $BASE_IMAGE AS base



FROM $STAGE_IMAGE AS stage



FROM base AS chain

# setup clang
COPY --from=stage /root/llvm/id/llvm /root/.llvm
ENV CC="/root/.llvm/bin/clang"
ENV CXX="/root/.llvm/bin/clang++"
