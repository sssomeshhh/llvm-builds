ARG END_IMAGE

FROM $END_IMAGE AS end

FROM end AS pack

# set args
ARG X

# pack artifacts
RUN cd /root/llvm && \
    du -sh id && \
    tar -cf it id && \
    rm -rf id && \
    ls -hls it && \
    xz -z9 it && \
    rm -rf it && \
    ls -hls it.xz
