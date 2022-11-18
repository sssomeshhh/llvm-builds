ARG BUILD_IMAGE_TAG

FROM $BUILD_IMAGE_TAG as llvm-build

FROM ubuntu:jammy as llvm-release

# copy artifacts
COPY --from=llvm-build /root/llvm/id/llvm /root
RUN /root/llvm/bin/clang --version
