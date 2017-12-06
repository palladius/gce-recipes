

cloudbuild-push:
	gcloud container builds submit --config cloudbuild.yaml .

cloudbuild-pull: cloudbuild-push
	 gcloud docker -- pull gcr.io/ric-cccwiki/custom-script-test

docker-run-customscripttest:
	gcloud docker -- run gcr.io/ric-cccwiki/custom-script-test
