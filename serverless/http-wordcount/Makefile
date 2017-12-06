
#https://cloud.google.com/functions/docs/quickstart

PROJECT_ID = "ric-cccwiki"
BUCKET_NAME = palladius-serverless
FUNCTION_NAME = "wordCount"
YOUR_REGION = "us-central1"
TEST_PAYLOAD = '{"bucket": "$(BUCKET_NAME)","file":"sample.txt"}'
#list:
#	gcloud beta functions describe helloWorld
#	gcloud beta functions logs read helloWorld

#deploy:#
#	gcloud beta functions deploy helloWorld --stage-bucket $(BUCKET_NAME) --trigger-topic hello_world

call-wordcount:
	gcloud alpha functions call $(FUNCTION_NAME) --data '{"bucket": "$(BUCKET_NAME)","file":"sample.txt"}'

curl:
	@echo Try: curl -X POST https://$(YOUR_REGION)-$(PROJECT_ID).cloudfunctions.net/$(FUNCTION_NAME) -H "Content-Type:application/json" --data $(TEST_PAYLOAD)

deploy:
	gcloud alpha functions deploy $(FUNCTION_NAME) --stage-bucket $(BUCKET_NAME) --trigger-http

setup-once:
	#gsutil mb -p $(PROJECT_ID) gs://$(BUCKET_NAME)/
	gsutil cp sample.txt gs://$(BUCKET_NAME)/

logs:
	gcloud beta functions logs read $(FUNCTION_NAME)
