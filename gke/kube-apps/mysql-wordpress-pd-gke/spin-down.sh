#!/bin/bash

. common.sh

# Docs: https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/

kubectl delete secret mysql-pass
#Run the following commands to delete all Deployments and Services:
kubectl delete deployment -l app=wordpress
kubectl delete deployment -l app=mysql3
kubectl delete service -l app=wordpress
kubectl delete service -l app=mysql3
#Run the following commands to delete the PersistentVolumeClaims and the PersistentVolumes:
kubectl delete pvc -l app=wordpress
#kubectl delete pv local-pv-1 local-pv-2