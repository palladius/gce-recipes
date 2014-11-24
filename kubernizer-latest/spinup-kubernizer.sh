#!/bin/bash

source ../constants.sh

# creates a different one every minute...
TIMESTAMPOLO=$(date +%Y%m%d-%H%M)
VER=0.9.2

HISTORY='
  0.9.2  ricc adding Google Storage...
'

set -x

gcloud --project "$PROJECT_ID" compute instances create "kubernizer-$TIMESTAMPOLO" \
	--zone "$FAVORITE_ZONE" --machine-type "$FAVORITE_MACHINE_TYPE" \
	--image debian-7 --scope storage-rw \
	--metadata-from-file startup-script=startup.sh

set +x

echo Try: gcutil ssh "kubernizer-$TIMESTAMPOLO" grep startupscript /var/log/syslog 


