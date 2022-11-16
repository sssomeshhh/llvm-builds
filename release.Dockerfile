ARG BASE_IMAGE_RELEASE

FROM $BASE_IMAGE_RELEASE as llvm-release

# set args
ARG RELEASE_TAG

# set envs
ENV LLVM_VERSION=$RELEASE_TAG

# unpack artifacts
ADD https://github.com/sssomeshhh/llvm-build/releases/download/$RELEASE_TAG/it.xz /usr/
