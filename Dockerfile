FROM ubuntu:jammy as llvm-build
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl gzip tar xz-utils zlib1g-dev
RUN apt-get install -y ccache clang-14 cmake make ninja-build
RUN apt-get install -y python3 python3-pip python3-venv
