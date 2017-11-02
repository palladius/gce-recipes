#!/bin/bash

VER=$(cat VERSION)


echo "Forcing latest to be latest and not forcing the VERSION so you only do it once ideally (immutable)"
sudo docker tag -f quickstart-image gcr.io/ric-cccwiki/quickstart-image
sudo docker tag quickstart-image gcr.io/ric-cccwiki/quickstart-image:v$VER

# this doesnt work as requires root :/
#gcloud docker -- push gcr.io/ric-cccwiki/quickstart-image
sudo /usr/local/google-cloud-sdk/bin/gcloud docker -- push -f gcr.io/ric-cccwiki/quickstart-image
sudo /usr/local/google-cloud-sdk/bin/gcloud docker -- push gcr.io/ric-cccwiki/quickstart-image:v$VER
