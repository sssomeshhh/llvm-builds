#!/usr/bin/bash

BD=/root/llvm/bd/llvm
ID=/root/llvm/id/llvm
SD=/root/llvm/sd/llvm

cmake \
    -S $SD \
    -B $BD \
    -G Ninja \
  # cmake opt-var
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=$CC \
    -DCMAKE_CXX_COMPILER=$CXX \
    -DCMAKE_INSTALL_PREFIX=$ID \
  # llvm opt-var
    -DLLVM_ENABLE_PROJECTS="all" \
    -DLLVM_PARALLEL_COMPILE_JOBS=$(nproc) \
    -DLLVM_TARGETS_TO_BUILD="all" \
    -DLLVM_USE_LINKER="lld" \
    ;
cmake \
    --build $BD \
    ;
cmake \
    --install $BD \
    ;
