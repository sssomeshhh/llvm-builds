#! /bin/bash

DOCKER_BUILDKIT=1

docker pull $3;
docker build . \
    --tag=pack-$1d:temp \
    --target=llvm-package \
    --build-arg BASE_IMAGE_PACKAGE=$3 \
    --build-arg X=$1 \
    --build-arg R=$2;
docker run --rm -it --name=cntnr-$1d pack-$1d:temp bash;
docker cp cntnr-$1d:$2/$1t.xz ./;
ls -hls $1t.xz;
