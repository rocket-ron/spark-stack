#!/bin/bash

if [ $# -gt 0 ]; then
    IMAGE=$1
else
    exit
fi

if [ $# -gt 1 ]; then
    TAG=$2
else
    TAG="latest"
fi

docker image build -t "${IMAGE}:${TAG}" $IMAGE
