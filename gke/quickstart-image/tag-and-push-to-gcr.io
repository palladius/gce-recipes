#!/bin/bash

VER=$(cat VERSION)

sudo docker tag quickstart-image gcr.io/ric-cccwiki/quickstart-image
sudo docker tag quickstart-image gcr.io/ric-cccwiki/quickstart-image:v$VER

# this doesnt work as requires root :/
#gcloud docker -- push gcr.io/ric-cccwiki/quickstart-image
sudo /usr/local/google-cloud-sdk/bin/gcloud docker -- push gcr.io/ric-cccwiki/quickstart-image
sudo /usr/local/google-cloud-sdk/bin/gcloud docker -- push gcr.io/ric-cccwiki/quickstart-image:v$VER
