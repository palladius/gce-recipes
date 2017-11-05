#!/bin/bash

# fatto SOLO per k8s su GKE che e' diverso...
# https://cloud.google.com/container-engine/docs/tutorials/persistent-disk

ZONE=europe-west1-b
PROJECT_ID=ric-cccwiki

if [ "aaa$MYSQL_ROOT_PASSWORD" = "aaa" ]; then
	echo MYSQL_ROOT_PASSWORD env not found. Please set export MYSQL_ROOT_PASSWORD=whateverPassYouWant
	exit 42
fi

set -x

# GCE prerequisites
gcloud --project "$PROJECT_ID" compute disks create --zone "$ZONE" --size 200GB mysql-disk
gcloud --project "$PROJECT_ID" compute disks create --zone "$ZONE" --size 200GB wordpress-disk
gcloud --project "$PROJECT_ID" compute disks create --zone "europe-west1-d" --size 200GB mysql-disk
gcloud --project "$PROJECT_ID" compute disks create --zone "europe-west1-d" --size 200GB wordpress-disk


kubectl create secret generic mysql-pass --from-literal=password=$MYSQL_ROOT_PASSWORD

kubectl create -f mysql.yaml
kubectl create -f mysql-service.yaml
kubectl create -f wordpress.yaml
kubectl create -f wordpress-service.yaml

#kubectl create -f local-volumes.yaml

#kubectl get pv

#kubectl create -f local-volumes.yaml

#kubectl get pv

#kubectl create secret generic mysql-pass --from-literal=password=YOUR_PASSWORD

#kubectl get secrets

#kubectl create -f mysql-deployment.yaml

#kubectl get pods

#kubectl create -f wordpress-deployment.yaml

#kubectl get services wordpress

