
# prep on GKE..
kubectl-prep: constants.sh
	gcloud components update
	gcloud components install kubectl
	gcloud container clusters get-credentials ricc-prod --zone europe-west1-b --project ric-cccwiki
	kubectl config current-context

constants.sh:
	cp constants.sh.dist constants.sh	
	@echo IMPORTANT! Please take time to edit constants.sh with your projectiod/zone/...
# set project_id TODO: ric-cccwiki
#configure:
#	kubectl config set-cluster ricc-prod
#	kubectl config current-context

