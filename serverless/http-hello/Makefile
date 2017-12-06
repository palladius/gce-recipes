
#https://cloud.google.com/functions/docs/quickstart

PROJECT_ID = "ric-cccwiki"
BUCKET_NAME = "palladius-serverless"
MYREGION = "us-central1"
FUNCTION_NAME = "helloWorldHttp"
FUNCTION2 = "helloGET"

list:
	gcloud beta functions describe $(FUNCTION_NAME)
	gcloud beta functions logs read $(FUNCTION_NAME)

curl:
	curl -X POST https://$(MYREGION)-$(PROJECT_ID).cloudfunctions.net/$(FUNCTION_NAME) -H "Content-Type:application/json" --data '{"message":"Keyboard Cat"}'
	curl -X POST https://$(MYREGION)-$(PROJECT_ID).cloudfunctions.net/$(FUNCTION2) -H "Content-Type:application/json" --data '{"message":"Keyboard Cat"}'

trigger:
	@echo "TODO ricc publish something on HTTP: $(FUNCTION_NAME)"
	#curl -X POST -H "Content-Type:application/json"  -d '{"message":"hello world!"}' YOUR_HTTP_TRIGGER_ENDPOINT
	curl "https://$(MYREGION)-$(PROJECT_ID).cloudfunctions.net/$(FUNCTION2)"

deploy-both:
	gcloud beta functions deploy $(FUNCTION_NAME) --stage-bucket $(BUCKET_NAME) --trigger-http 
	gcloud beta functions deploy helloGET --stage-bucket $(BUCKET_NAME) --trigger-http
