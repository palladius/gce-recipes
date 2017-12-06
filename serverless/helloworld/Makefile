
#https://cloud.google.com/functions/docs/quickstart

PROJECT_ID = "ric-cccwiki"
BUCKET_NAME = "palladius-serverless"


list:
	gcloud beta functions describe helloWorld
	gcloud beta functions logs read helloWorld

deploy:
	gcloud beta functions deploy helloWorld --stage-bucket $(BUCKET_NAME) --trigger-topic hello_world


setup-once:
	gsutil mb -p $(PROJECT_ID) gs://$(BUCKET_NAME)/
