VERSION = $(shell cat VERSION)


build:
	sudo docker build -t quickstart-image .

images:
	sudo docker images | grep quickstart-image

pull-latest:
	sudo /usr/local/google-cloud-sdk/bin/gcloud docker -- pull gcr.io/ric-cccwiki/quickstart-image

run-latest-p80:
	sudo docker run -p 80:80 gcr.io/ric-cccwiki/quickstart-image

run-latest-p3008:
	sudo docker run -it -p 3008:80 gcr.io/ric-cccwiki/quickstart-image

tag-and-push: build images
	../tag-and-push-to-gcrio.sh quickstart-image $(VERSION)

kubectl-run:
	kubectl run prova-quickstart --image=gcr.io/ric-cccwiki/quickstart-image

