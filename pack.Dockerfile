ARG END_IMAGE

FROM $END_IMAGE as pack

# set args
ARG X
ARG R

# pack artifacts
WORKDIR /root

RUN cd $R && \
    rm -rf $Xd/.git && \
    du -sh $Xd && \
    tar -cf $Xt $Xd && \
    rm -rf $Xd && \
    ls -hls $Xt && \
    xz -z9 $Xt && \
    rm -rf $Xt && \
    ls -hls $Xt.xz
