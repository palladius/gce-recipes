#!/bin/bash

# fatto SOLO per k8s su GKE che e' diverso...
# https://cloud.google.com/container-engine/docs/tutorials/persistent-disk

. common.sh

yellow "Purging DISKS! Crtl-C within next two seconds to abort!"

gcloud --project "$PROJECT_ID" compute disks delete --zone "$ZONE" $MYSQLDISKNAME
gcloud --project "$PROJECT_ID" compute disks delete --zone "$ZONE" $WORDPRESS_DISK_NAME
#gcloud --project "$PROJECT_ID" compute disks create --zone "europe-west1-d" --size 200GB $MYSQLDISKNAME
#gcloud --project "$PROJECT_ID" compute disks create --zone "europe-west1-d" --size 200GB $WORDPRESS_DISK_NAME
