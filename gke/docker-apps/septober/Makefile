
VERSION = $(shell cat VERSION)
APPNAME = septober
PRIVATEDB = /bin/false
# much before but..
MAKEFILE_DATE = "20171206"
CODEURL = https://github.com/palladius/septober
GAE_PROJECT_ID = 'septober-184814'
GAE_PROJECT_NUMBER = "614371884085"
LOCALPORT = 3005

# code: https://github.com/palladius/septober
# broken: http://septober.heroku.com

$(APPNAME)-files:
	git clone $(CODEURL) $(APPNAME)-files

build: $(APPNAME)-files
	# not true anymore since I use the palladius/ one. 
	# @echo "If not ruby image present, try: cd ../ruby-1.8.7/ && make build"
	docker build -t $(APPNAME) .

run-local-bash: build
	docker run -it -p 0.0.0.0:$(LOCALPORT):3000 $(APPNAME) bash

run-local-prod:
	docker run -it -p 0.0.0.0:$(LOCALPORT):3000 $(APPNAME) rails server -e production

run-local-dev:
	docker run -it -p 0.0.0.0:$(LOCALPORT):3000 $(APPNAME) rails server

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

push-to-flex:
	@echo this doesnt work simply as it requires a PUBLIC ruby187 Docker image. TODO ricc push to 
	gcloud --project $(GAE_PROJECT_ID) app deploy
