#! /bin/bash

cd $2;
du -sh $1d;
tar -cf $1t $1d;
rm -rf $1d;
ls -hls $1t;
xz -z9 $1t;
rm -rf $1t;
ls -hls $1t.xz;
