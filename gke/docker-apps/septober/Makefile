
VERSION = $(shell cat VERSION)
APPNAME = septober
PRIVATEDB = /bin/false
# much before but..
MAKEFILE_DATE = "20171206"
CODEURL = https://github.com/palladius/septober
# https://hub.docker.com/r/palladius/pasta/
# code: https://github.com/palladius/septober
# broken: http://septober.heroku.com

septober-files: $(APPNAME)-files 

$(APPNAME)-files:
	git clone $(CODEURL) $(APPNAME)-files

build: $(APPNAME)-files
	docker build -t $(APPNAME) .

run-local: build
	docker run -it -p 0.0.0.0:3000:3000 $(APPNAME) bash

run-prod:
	docker run -it -p 0.0.0.0:3000:3000  pasta script/server -e production


docker-images:
	docker images | grep $(APPNAME)

versions:
	ruby -v
	gem -v
	bundle -v
	gem -v
	#/root/.rbenv/versions/1.8.7-p375/bin/bundle -v

tag-and-push: build
	../tag-and-push-to-gcrio.sh $(APPNAME) $(VERSION)

# only used with 5yr-old distros.. see https://hub.docker.com/r/palladius/septober/
debug-v1-manhaus-dev:
	docker run -p 3007:3000 -it palladius/septober:v1 "cd /home/riccardo/git/septober/ && make run"

debug-v1.2-manhause-prod:
	docker run -p 3007:3000 palladius/septober:v1.2 

# Looks like 2.0 doesnt work
#debug-v2.0-manhause-nonva:
#	docker run -p 3007:3000 palladius/septober:v2.0 /dockerize/run.sh