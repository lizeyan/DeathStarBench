#!/bin/bash

cd $(dirname $0)/


EXEC=docker

REPO="docker.peidan.me/"
USER="lizytalk"

TAG="latest"

IMAGE=social-network-microservices

# ENTER THE ROOT FOLDER
cd ../
ROOT_FOLDER=$(pwd)
echo ROOT_FOLDER=${ROOT_FOLDER}

cd $ROOT_FOLDER
$EXEC build -t "$REPO$USER"/"$IMAGE":"$TAG" -f Dockerfile .
$EXEC push "$REPO$USER"/"$IMAGE":"$TAG"
cd $ROOT_FOLDER


cd - >/dev/null
