ARG SETUP_IMAGE

FROM $SETUP_IMAGE as chain

# set args
ARG BD=/root/llvm/bd/llvm
ARG ID=/root/llvm/id/llvm
ARG SD=/root/llvm/sd/llvm

# build artifacts
RUN cmake \
    -S $SD \
    -B $BD \
    -G Ninja \
  # cmake opt-var
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=$CC \
    -DCMAKE_CXX_COMPILER=$CXX \
    -DCMAKE_INSTALL_PREFIX=$ID \
  # llvm opt-var
#    -DLLVM_ENABLE_LIBCXX=ON \
#    -DLLVM_ENABLE_LTO="Off" \
#    -DLLVM_ENABLE_MODULES=ON \
    -DLLVM_ENABLE_PROJECTS="all" \
    -DLLVM_PARALLEL_COMPILE_JOBS=$(nproc)
#    -DLLVM_STATIC_LINK_CXX_STDLIB=ON \
#    -DLLVM_TARGETS_TO_BUILD="all" \
#    -DLLVM_USE_LINKER="lld"

RUN cmake --build $BD
RUN cmake --install $BD
