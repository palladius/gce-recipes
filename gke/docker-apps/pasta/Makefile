
VERSION = $(shell cat VERSION)
APPNAME = pasta
PRIVATEDB = /bin/false
# much before but..
MAKEFILE_DATE = "20171206"
# https://hub.docker.com/r/palladius/pasta/
CODEURL = https://github.com/palladius/pasta
GAE_PROJECT_ID = 'pasta-188214'

pasta-files: 
	git clone $(CODEURL) $(APPNAME)-files

build: $(APPNAME)-files
	docker build -t $(APPNAME) .

run-local: build
	docker run -it -p 0.0.0.0:3000:3000 $(APPNAME) bash

run-prod:
	docker run -it -p 0.0.0.0:3000:3000 pasta script/server -e production

debug-v.2alpha:
	docker run -it palladius/pasta:v0.2alpha bash

docker-images:
	docker images | grep pasta

versions:
	ruby -v 
	gem -v 
	bundle -v 
	gem -v  
	#/root/.rbenv/versions/1.8.7-p375/bin/bundle -v

tag-and-push: build
	../tag-and-push-to-gcrio.sh $(APPNAME) $(VERSION)

push-to-flex:
	@echo this doesnt work simply as it requires a PUBLIC ruby187 Docker image. TODO ricc push to 
	gcloud --project $(GAE_PROJECT_ID) app deploy

gae-push: push-to-flex

##############################################################################
# THESE WORK but I'm working ona  repeatable working pipeline.. bear with me.
##############################################################################

#run-v1.1-p3000:
#	docker run -p 3000:3000 -ti palladius/pasta:v1.1

#debug-v1.1-p3000:
#	docker run -p 3000:3000 -ti palladius/pasta:v1.1 bash
