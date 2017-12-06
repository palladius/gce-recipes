


PROJECT_ID = "ric-cccwiki"
BUCKET_NAME = "palladius-serverless"
MYREGION = "us-central1"
FUNCTION_NAME = "helloGCS"


deploy:
	@echo Ricc I use same bucket for code and trigger for rapid protyping but normally youd have two..
	gcloud beta functions deploy helloGCS --stage-bucket $(BUCKET_NAME) --trigger-bucket $(BUCKET_NAME)

test:
	gsutil cp gcf-test.txt gs://$(BUCKET_NAME)/
	gcloud beta functions logs read --limit 50
