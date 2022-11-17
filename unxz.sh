#! /bin/bash

cd $2;
ls -hls $1t.xz;
unxz $1t.xz;
rm -rf $1t.xz;
ls -hls $1t;
tar -xf $1t;
rm -rf $1t;
du -sh $1d;
