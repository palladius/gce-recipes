
#!/bin/bash

# Docs: https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/
# TODO: fix hostPath 

kubectl create -f local-volumes.yaml

kubectl get pv

kubectl create secret generic mysql-pass --from-literal=password=YOUR_PASSWORD

kubectl get secrets

kubectl create -f mysql-deployment.yaml

kubectl get pods

kubectl create -f wordpress-deployment.yaml

kubectl get services wordpress

