ARG BUILD_IMAGE_TAG

FROM $BUILD_IMAGE_TAG as llvm-package

# set args
ARG X
ARG R

# pack artifacts
WORKDIR /root
COPY xz.sh .
RUN ./xz.sh $X $R
