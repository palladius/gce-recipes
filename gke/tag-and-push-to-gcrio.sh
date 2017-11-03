#!/bin/bash

IMAGE_NAME=${1:-sobenme}
IMAGE_VERSION=${2:-0.0.1alpha}

GCLOUD="sudo /usr/local/google-cloud-sdk/bin/gcloud"

echo "Forcing latest to be latest and not forcing the VERSION so you only do it once ideally (immutable)"
sudo docker tag -f $IMAGE_NAME gcr.io/ric-cccwiki/$IMAGE_NAME
sudo docker tag -f $IMAGE_NAME gcr.io/ric-cccwiki/$IMAGE_NAME:latest
sudo docker tag $IMAGE_NAME gcr.io/ric-cccwiki/$IMAGE_NAME:v$IMAGE_VERSION

# this doesnt work as requires root :/
#gcloud docker -- push gcr.io/ric-cccwiki/$IMAGE_NAME
$GCLOUD docker -- push -f gcr.io/ric-cccwiki/$IMAGE_NAME
$GCLOUD docker -- push gcr.io/ric-cccwiki/$IMAGE_NAME:v$IMAGE_VERSION
$GCLOUD docker -- push gcr.io/ric-cccwiki/$IMAGE_NAME:latest
