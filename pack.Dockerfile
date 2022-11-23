ARG END_IMAGE

FROM $END_IMAGE AS end



FROM end AS pack

# set args
ARG X

# pack artifacts
RUN cd /root/llvm && \
    du -sh $X"d" && \
    tar -cf $X"t" $X"d" && \
    rm -rf $X"d" && \
    ls -hls $X"t" && \
    xz -z9 $X"t" && \
    rm -rf $X"t" && \
    ls -hls $X"t".xz
