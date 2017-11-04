#!/bin/bash

# fatto SOLO per k8s su GKE che e' diverso...
# https://cloud.google.com/container-engine/docs/tutorials/persistent-disk


kubectl create -f local-volumes.yaml

kubectl get pv

kubectl create secret generic mysql-pass --from-literal=password=YOUR_PASSWORD

kubectl get secrets

kubectl create -f mysql-deployment.yaml

kubectl get pods

kubectl create -f wordpress-deployment.yaml

kubectl get services wordpress

