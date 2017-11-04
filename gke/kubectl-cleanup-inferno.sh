#!/bin/bash

# kubectl-cleanup-inferno.sh

# cleanup redis PHP guestbook
for APP in redis guestbook ; do
	kubectl delete deployment -l app=$APP
	kubectl delete service -l app=$APP
end

mysql-wordpress-pd/spin-down.sh
