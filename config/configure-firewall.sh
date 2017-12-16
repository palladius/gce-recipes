#!/bin/bash

RUBINO_IP="146.148.110.57"
RUBINONEDOCKER_IP="35.226.6.232"
CASARIC_ZURIGO="77.56.174.238"
GUGOL_ZURIGO="104.132.228.0/24" # "104.132.228.11"
GUGOL_ZURIGO_IPv6="2a00:79e0:60:0:991b:34e6:b8ef:762"
KUBERNETES_RICC_PROD=$( gcloud --project ric-cccwiki compute instances list  --format='csv(name,EXTERNAL_IP)' | egrep ^gke-ricc-prod | sort  | cut -f 2 -d, | xargs | sed -e 's/ /,/g' )
#gcloud compute firewall-rules update gcerecipes-allow-rorrume --allow tcp:3000-3100,icmp
#gcloud compute firewall-rules create gcerecipes-allow-rorrume --allow tcp:3000-3100,icmp --source-tags "mysql-client" --target-tags "mysql-server"

# Authorize MySQL
# https://console.cloud.google.com/sql/instances/prod/authorization?project=ric-cccwiki
# Currently: 

######################################################################################
# fails since its in different regions
#gcloud --project ric-cccwiki sql instances patch prod --authorized-gae-apps ric-cccwiki
#gcloud --project ric-cccwiki sql instances patch prod --authorized-gae-apps gae-debiti

# https://console.cloud.google.com/sql/instances/prod/authorization?project=ric-cccwiki
# Docs: https://cloud.google.com/sdk/gcloud/reference/sql/instances/patch

echo "KUBERNETES_RICC_PROD: $KUBERNETES_RICC_PROD"

gcloud --project ric-cccwiki --quiet sql instances patch prod --authorized-networks="$RUBINONEDOCKER_IP,$RUBINO_IP,$CASARIC_ZURIGO,$GUGOL_ZURIGO,$KUBERNETES_RICC_PROD"

echo fatto