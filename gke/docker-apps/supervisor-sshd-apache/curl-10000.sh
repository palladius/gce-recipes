#!/bin/bash

IP="$(boot2docker ip | cut -f: -d 2 || echo 192.168.59.103)"
HASH=$( docker ps |grep palladius/supervisord:1.1 | awk '{print $1}' ) # 634d9c0a9a28
PORT="$(docker port $(docker ps |grep palladius/supervisord:1.1 | awk '{print $1}') 10000)" # 0.0.0.0:49XXX

URL=$(echo $PORT | sed -e s/0.0.0.0/$IP/)
set -x
curl "http://$URL/"
