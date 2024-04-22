ARG SETUP_IMAGE

FROM $SETUP_IMAGE AS setup

FROM setup AS stage

# set llvm args
ARG LLVM_PROJECTS="all"
ARG LLVM_RUNTIMES="all"
ARG LLVM_TARGETS_TO_BUILD="all"

# set dir args
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
        -DLLVM_ENABLE_PROJECTS=$LLVM_PROJECTS \
        -DLLVM_ENABLE_RUNTIMES=$LLVM_RUNTIMES \
        -DLLVM_TARGETS_TO_BUILD=$LLVM_TARGETS_TO_BUILD \
        -DLLVM_USE_LINKER="lld" \
        -DLLVM_PARALLEL_COMPILE_JOBS=$(nproc)
RUN cmake --build $BD
RUN cmake --install $BD
