ARG BASE_IMAGE
ARG CHAIN_IMAGE

FROM $CHAIN_IMAGE as chain

FROM $BASE_IMAGE as stage

# setup clang
COPY --from=chain /root/llvm/id/llvm /root/.llvm
ENV CC="/root/.llvm/bin/clang"
ENV CXX="/root/.llvm/bin/clang++"
