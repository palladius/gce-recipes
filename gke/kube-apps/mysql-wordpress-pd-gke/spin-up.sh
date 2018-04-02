#!/bin/bash

# fatto SOLO per k8s su GKE che e' diverso...
# https://cloud.google.com/container-engine/docs/tutorials/persistent-disk

. common.sh

if [ "aaa$MYSQL_ROOT_PASSWORD" = "aaa" ]; then
	echo MYSQL_ROOT_PASSWORD env not found. Please set export MYSQL_ROOT_PASSWORD=whateverPassYouWant
	exit 42
fi

set -x

# GCE prerequisites
gcloud --project "$PROJECT_ID" compute disks create --zone "$ZONE" --size 200GB $MYSQLDISKNAME
gcloud --project "$PROJECT_ID" compute disks create --zone "$ZONE" --size 200GB $WORDPRESS_DISK_NAME
#gcloud --project "$PROJECT_ID" compute disks create --zone "europe-west1-d" --size 200GB $MYSQLDISKNAME
#gcloud --project "$PROJECT_ID" compute disks create --zone "europe-west1-d" --size 200GB $WORDPRESS_DISK_NAME

kubectl create secret generic mysql-pass --from-literal=password=$MYSQL_ROOT_PASSWORD

kubectl create -f mysql.yaml
kubectl create -f mysql-service.yaml
kubectl create -f wordpress.yaml
kubectl create -f wordpress-service.yaml

#kubectl create -f local-volumes.yaml
#kubectl create -f mysql-deployment.yaml
#kubectl create -f wordpress-deployment.yaml

#kubectl get pv
#kubectl get secrets
#kubectl get pods
#kubectl get services wordpress

