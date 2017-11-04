
# prep on GKE..
kubectl-prep:
	gcloud components update
	gcloud components install kubectl
	gcloud container clusters get-credentials ricc-prod --zone europe-west1-b --project ric-cccwiki
	kubectl config current-context

# set project_id TODO: ric-cccwiki
#configure:
#	kubectl config set-cluster ricc-prod
#	kubectl config current-context

