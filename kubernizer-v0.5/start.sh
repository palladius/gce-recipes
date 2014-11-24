#!/bin/bash

source ../constants.sh

# creates a different one every minute...
TIMESTAMPOLO=$(date +%Y%m%d-%H%M)
VER="0.9.6"
VMNAME="$USER-kubernizer05-$TIMESTAMPOLO"

HISTORY='
  0.9.6  ricc correct scopes (Cluod Stora+Compute R/W)
  0.9.5  ricc tolto latest dal nome :)
  0.9.4  ricc branching from kubernizer-latest
  0.9.3  ricc Adding VMNAME and constants.sh
  0.9.2  ricc adding Google Storage...
'

set -x
# note: storage-rw is needed for writing to GCS from Kubernetes
gcloud --project "$PROJECT_ID" compute instances create "$VMNAME" \
	--zone "$FAVORITE_ZONE" --machine-type "$FAVORITE_MACHINE_TYPE" \
	--image debian-7 \
	--scopes "https://www.googleapis.com/auth/compute" "https://www.googleapis.com/auth/devstorage.read_write" \
	--tags development --tags kubernetes-client \
	--maintenance-policy "MIGRATE" \
	--metadata "kubernizer-ver=$VER" \
	--metadata-from-file startup-script=startup.sh

set +x

echo Try: gcutil --project "$PROJECT_ID" ssh "$VMNAME" grep startupscript /var/log/syslog


