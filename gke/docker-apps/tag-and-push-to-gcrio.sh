#!/bin/bash

VERSION=1.1

IMAGE_NAME=${1:-sobenme}
IMAGE_VERSION=${2:-0.0.1alpha}

GCLOUD="sudo /usr/local/google-cloud-sdk/bin/gcloud"

echo "1. Forcing latest to be latest and not forcing the VERSION so you only do it once ideally (immutable)"
sudo docker tag $IMAGE_NAME gcr.io/ric-cccwiki/$IMAGE_NAME:v$IMAGE_VERSION
sudo docker tag -f $IMAGE_NAME gcr.io/ric-cccwiki/$IMAGE_NAME
sudo docker tag -f $IMAGE_NAME gcr.io/ric-cccwiki/$IMAGE_NAME:latest

echo "2. Pushing now to gcr.io/ric-cccwiki:"
# this doesnt work as requires root :/
$GCLOUD docker -- push gcr.io/ric-cccwiki/$IMAGE_NAME:v$IMAGE_VERSION
$GCLOUD docker -- push gcr.io/ric-cccwiki/$IMAGE_NAME
$GCLOUD docker -- push gcr.io/ric-cccwiki/$IMAGE_NAME:latest
