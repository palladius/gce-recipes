
PROJECT_ID = "ric-cccwiki"
BUCKET_NAME = palladius-serverless

deploy: deploy1 deploy2 deploy3

# it works!
deploy1:
	gcloud alpha functions deploy helloBackgroundFromPubSub --stage-bucket $(BUCKET_NAME) --trigger-topic hello-bkg-ps
# it works!
deploy2:
	gcloud alpha functions deploy helloBackgroundFromGCS    --stage-bucket $(BUCKET_NAME) --trigger-bucket $(BUCKET_NAME)
# Problematic
deploy3:
	gcloud beta functions deploy helloBackgroundBroken --stage-bucket $(BUCKET_NAME) --trigger-http

push: deploy

call:
	gcloud beta functions call helloBackgroundFromPubSub --data '{"data":"dGVzdCB1c2Vy"}'
	gcloud beta functions call helloBackgroundFromGCS --data '{"name":"test.txt"}'
	gcloud beta functions call helloBackgroundBroken --data '{"foobar":"yellow", "name":"Macciao"}'
