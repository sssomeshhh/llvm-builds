FROM ubuntu:jammy as llvm-release

# set args
ARG BUILD_IMAGE_TAG

# copy artifacts
COPY --from=$BUILD_IMAGE_TAG /root/llvm/id/llvm /root
RUN /root/llvm/bin/clang --version
