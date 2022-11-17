ARG BASE_IMAGE_RELEASE

FROM $BASE_IMAGE_RELEASE as llvm-release

# set args
ARG RELEASE_TAG

# set envs
ENV LLVM_VERSION=$RELEASE_TAG

# install dependencies
ENV DEBIAN_FRONTEND='noninteractive'
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl tar xz-utils libc++-dev libc++abi-dev

# set args
ARG X
ARG R

# unpack artifacts
WORKDIR /root
RUN curl -Lo it.xz https://github.com/sssomeshhh/llvm-build/releases/download/$RELEASE_TAG/it.xz
COPY unxz.sh .
RUN ./unxz.sh $X $R
RUN ./llvm/bin/clang --version
