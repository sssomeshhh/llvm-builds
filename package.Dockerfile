ARG BASE_IMAGE_PACKAGE

FROM $BASE_IMAGE_PACKAGE as llvm-package

# set args
ARG X
ARG R

# pack artifacts
WORKDIR /root
COPY xz.sh .
RUN ./xz.sh $X $R
