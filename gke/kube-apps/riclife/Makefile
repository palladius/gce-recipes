

PODNAME = riclife-v092-test

test:
	#kubectl get po
	kubectl get pod $(PODNAME)
	kubectl describe po $(PODNAME)

kubectl-exec-riclife-bash:
	kubectl exec -it riclife-v092 -c gcr.io/ric-cccwiki/riclife:v0.9.2 bash

kubectl-exec-riclife-prod:
	kubectl exec -it riclife-v092 -c gcr.io/ric-cccwiki/riclife:v0.9.2 script/server -e production

docker-run-riclife-prod:
	gcloud docker -- run -it gcr.io/ric-cccwiki/riclife:funge riclife/script/server -e production

pod1-up:
	kubectl create -f pod-riclife-v092.yaml

pod1-down:
	kubectl delete -f pod-riclife-v092.yaml 

# https://kubernetes.io/docs/tasks/debug-application-cluster/get-shell-running-container/
# also interesting: https://kubernetes.io/docs/reference/kubectl/docker-cli-to-kubectl/
bash-into-riclife:
	kubectl exec -it $(PODNAME) -- /bin/bash
