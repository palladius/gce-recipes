
#https://cloud.google.com/functions/docs/quickstart

PROJECT_ID = "ric-cccwiki"
BUCKET_NAME = palladius-serverless

list:
	gcloud beta functions describe helloWorld
	gcloud beta functions logs read helloWorld

deploy:
	gcloud beta functions deploy helloWorld --stage-bucket $(BUCKET_NAME) --trigger-topic hello_world

call-wordcount:
	gcloud alpha functions call wordCount --data '{"bucket": "$(BUCKET_NAME)","file":"sample.txt"}'

setup-once:
	#gsutil mb -p $(PROJECT_ID) gs://$(BUCKET_NAME)/
	 gsutil cp sample.txt gs://$(BUCKET_NAME)
	 gcloud alpha functions deploy wordCount --stage-bucket $(BUCKET_NAME) --trigger-http

