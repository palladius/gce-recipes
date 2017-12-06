
#https://cloud.google.com/functions/docs/quickstart

PROJECT_ID = "ric-cccwiki"
BUCKET_NAME = "palladius-serverless"


list:
	gcloud beta functions describe helloWorld
	gcloud beta functions logs read helloWorld

trigger:
	@echo "TODO ricc publuish something on pubsub: hello_world"

deploy:
	@echo This is called by PubSub
	gcloud beta functions deploy helloWorldPS --stage-bucket $(BUCKET_NAME) --trigger-topic hello_world

setup-once:
	gsutil mb -p $(PROJECT_ID) gs://$(BUCKET_NAME)/
