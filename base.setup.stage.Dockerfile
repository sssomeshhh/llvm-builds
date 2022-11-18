ARG BASE_IMAGE
ARG CHAIN_IMAGE


FROM $BASE_IMAGE as llvm-base

FROM $CHAIN_IMAGE as llvm-chain

FROM llvm-base as llvm-stage

# setup clang
COPY --from=llvm-chain /root/llvm/id/llvm /root/.llvm
ENV CC="/root/.llvm/bin/clang"
ENV CXX="/root/.llvm/bin/clang++"
