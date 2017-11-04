
#!/bin/bash

# Docs: https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/
# TODO: fix hostPath 

ZONE=europe-west1-b
PROJECT_ID=ric-cccwiki

if [ "aaa$MYSQL_ROOT_PASSWORD" = "aaa" ]; then
	echo MYSQL_ROOT_PASSWORD env not found. Please set export MYSQL_ROOT_PASSWORD=whateverPassYouWant
	exit 42
fi

# GCE prerequisites
gcloud compute disks create --zone "$ZONE" --size 200GB mysql-disk
gcloud compute disks create --zone "$ZONE" --size 200GB wordpress-disk

kubectl create -f local-volumes.yaml

kubectl get pv

kubectl create secret generic mysql-pass --from-literal=password=$MYSQL_ROOT_PASSWORD

kubectl get secrets

kubectl create -f mysql-deployment.yaml

kubectl get pods

kubectl create -f wordpress-deployment.yaml

kubectl get services wordpress

