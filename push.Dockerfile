ARG END_IMAGE

FROM $END_IMAGE as end

FROM ubuntu:jammy as llvm-push

# copy artifacts
COPY --from=end /root/llvm/id/llvm /root
RUN /root/llvm/bin/clang --version
