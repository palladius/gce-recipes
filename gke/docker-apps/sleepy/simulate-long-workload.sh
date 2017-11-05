#!/bin/bash

# We simulate a batch docker cvontainer which does heavy lift-and-shift
# but in practice it only sleeps for XX seconds
# and logs what it does. it also support a description
# Usage: $) <SLEEP_SECONDS> <WORKLOAD_NAME>
# and it logs all

SLEEP_SECONDS=${1:-3600}
WORKLOAD_NAME=${2:-Acme Hadoop Services}


function logga_msg() {
	gcloud beta logging write sleepy_msg "$1: hostname:$(hostname) doockercontainer:TODO"  
}

echo 1. Hello Im a sleepy process working for: $WORKLOAD_NAME
# TODO gcloud log what I do
logga_msg START

echo 2. Im about to work REALLY hard for: $SLEEP_SECONDS seconds.. wait for it..
sleep "$SLEEP_SECONDS"

logga_msg END
# TODO gcloud log what I do
echo 3. Now Im done with: $WORKLOAD_NAME
