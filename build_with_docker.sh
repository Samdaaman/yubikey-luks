#!/bin/sh

IMAGE_NAME=yubikey-luks-build
BUILD_FILE=yubikey-luks_0.6~dev1_all.deb

docker build -t $IMAGE_NAME . || { echo 'docker build failed' ; exit 1; }
docker create -ti --name $IMAGE_NAME $IMAGE_NAME || { echo 'docker create failed' ; exit 1; }
docker cp $IMAGE_NAME:/src/DEBUILD/$BUILD_FILE ./$BUILD_FILE || { echo 'docker copy failed' ; exit 1; }
docker rm -f $IMAGE_NAME

echo
echo $BUILD_FILE created
echo Run \"dpkg -i $BUILD_FILE\" to install