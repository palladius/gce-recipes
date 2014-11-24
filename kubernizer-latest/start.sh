#!/bin/bash

source ../constants.sh

# creates a different one every minute...
TIMESTAMPOLO=$(date +%Y%m%d-%H%M)
VER="0.9.4"
VMNAME="$USER-kubernizer-latest-$TIMESTAMPOLO"

HISTORY='
  0.9.4  ricc Adding Compute RW needed for kubernetes..
  0.9.3  ricc Adding VMNAME and constants.sh
  0.9.2  ricc adding Google Storage...
'

set -x
# note: storage-rw is needed for writing to GCS from Kubernetes 
gcloud --project "$PROJECT_ID" compute instances create "$VMNAME" \
	--zone "$FAVORITE_ZONE" --machine-type "$FAVORITE_MACHINE_TYPE" \
	--image debian-7 \
	--metadata "kubernizer-ver=$VER" \
	--metadata-from-file startup-script=startup.sh \
	--scopes "https://www.googleapis.com/auth/compute" "https://www.googleapis.com/auth/devstorage.read_write" \
	--tags development --tags kubernetes-client \
	--maintenance-policy "MIGRATE" 
# https://www.googleapis.com/auth/compute
# https://www.googleapis.com/auth/devstorage.read_write


set +x

echo Try: gcutil ssh "$VMNAME" grep startupscript /var/log/syslog 


