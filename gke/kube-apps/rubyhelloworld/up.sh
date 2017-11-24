#!/bin/bash

# up.sh

kubectl run gcr-flex -it --image us.gcr.io/ric-cccwiki/appengine/default.flex-bookshelf -l app=test
kubectl run gcr-ruby-helloworld -it --image us.gcr.io/ric-cccwiki/appengine/default.ruby-helloworld-0-9-0 -l test
 