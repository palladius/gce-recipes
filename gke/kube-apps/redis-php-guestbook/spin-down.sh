#!/bin/bash

# Docs: https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/
MYAPP=guestbook

#kubectl delete secret mysql-pass

#Run the following commands to delete all Deployments and Services:
kubectl delete deployment -l app=$MYAPP
kubectl delete service -l app=$MYAPP
kubectl delete pvc -l app=$MYAPP

#Run the following commands to delete the PersistentVolumeClaims and the PersistentVolumes:
#kubectl delete pvc -l app=$MYAPP
#kubectl delete pv local-pv-1 local-pv-2