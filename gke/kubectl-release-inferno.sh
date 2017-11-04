#!/bin/bash

NAMESPACE=riccardume

# it works! https://blog.codeship.com/getting-started-with-kubernetes/
kubectl run ghost --image=ghost --port=2368
kubectl run ghost2 --image=ghost --env="app=ghost" --port=12345 --replicas=2 --dry-run=false
kubectl expose deployment ghost  --type="NodePort"
kubectl expose deployment ghost2 --type="NodePort"
#kubectl describe service ghost
#kubectl describe service ghost2
#kubectl scale deployment ghost --replicas=4

@echo run mono-pod quickstart-image..
kubectl run poddino-quickstart-image --image=gcr.io/ric-cccwiki/quickstart-image

@echo Spinning up Redis Guestbook..
kubectl create -f redis-php-guestbook/

@echo Spinning up Mysql Wordpress with Persistent Volumes!
mysql-wordpress-pd/spin-up.sh

#docker run -p 3005:2368 -it ghost