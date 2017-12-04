
PROJECTID = ric-cccwiki
FAV_ZONE = europe-west1-b

# prep on GKE..
kubectl-prep: constants.sh
	gcloud components update
	gcloud components install kubectl
	gcloud container clusters get-credentials ricc-prod --zone europe-west1-b --project $(PROJECTID)
	kubectl config current-context

constants.sh:
	cp constants.sh.dist constants.sh	
	@echo IMPORTANT! Please take time to edit constants.sh with your projectiod/zone/...
# set project_id TODO: ric-cccwiki
#configure:
#	kubectl config set-cluster ricc-prod
#	kubectl config current-context


cloudbuild-push:
	 gcloud container builds submit --config cloudbuild.yaml .

cloudbuild-docker-test:
	gcloud docker -- pull gcr.io/$(PROJECTID)/custom-script-test
	docker run gcr.io/$(PROJECTID)/custom-script-test

