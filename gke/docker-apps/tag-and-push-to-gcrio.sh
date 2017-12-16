#!/bin/bash

VERSION=1.2a

IMAGE_NAME=${1:-sobenme}
IMAGE_VERSION=${2:-0.0.1alpha}

GCLOUD="gcloud"

set -x
#set -e

echo "1. Forcing latest to be latest BUT not forcing the VERSION so you only do it once ideally (immutable)"
# See https://docs.docker.com/engine/reference/commandline/tag/#description
# Usage: docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
docker tag $IMAGE_NAME gcr.io/ric-cccwiki/$IMAGE_NAME:v$IMAGE_VERSION
docker tag $IMAGE_NAME gcr.io/ric-cccwiki/$IMAGE_NAME
docker tag $IMAGE_NAME gcr.io/ric-cccwiki/$IMAGE_NAME:latest

echo "2. Pushing now to gcr.io/ric-cccwiki:"
# this doesnt work as requires root :/
$GCLOUD docker -- push gcr.io/ric-cccwiki/$IMAGE_NAME:v$IMAGE_VERSION
$GCLOUD docker -- push gcr.io/ric-cccwiki/$IMAGE_NAME
$GCLOUD docker -- push gcr.io/ric-cccwiki/$IMAGE_NAME:latest
