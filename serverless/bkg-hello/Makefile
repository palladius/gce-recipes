
PROJECT_ID = "ric-cccwiki"
BUCKET_NAME = palladius-serverless

deploy:
	gcloud alpha functions deploy helloBackgroundFromPubSub --stage-bucket $(BUCKET_NAME) --trigger-topic hello-bkg-ps
	gcloud alpha functions deploy helloBackgroundFromGCS    --stage-bucket $(BUCKET_NAME) --trigger-bucket

push: deploy

call:
	gcloud beta functions call helloBackgroundFromPubSub --data '{"data":"dGVzdCB1c2Vy"}'
	gcloud beta functions call helloBackgroundFromGCS --data '{"name":"test.txt"}'
