
VERSION = $(shell cat VERSION)
APPNAME = ricniftystore
PRIVATEDB = /bin/true
LOCAL_PORT = 3002

ricniftystore-files: 
	git clone https://github.com/palladius/riccardo_nifty_store $(APPNAME)-files

build: ricniftystore-files
	docker build -t $(APPNAME) .

run-local-bash: build
	docker run -it -p 0.0.0.0:$(LOCAL_PORT):3000 $(APPNAME) bash

run-local-dev: build
	docker run -it -p 0.0.0.0:$(LOCAL_PORT):3000 $(APPNAME) script/server

run-local-prod: build
	docker run -it -p 0.0.0.0:$(LOCAL_PORT):3000 $(APPNAME) script/server -e production

docker-images:
	docker images | grep ricniftystore

versions:
	ruby -v 
	gem -v 
	bundle -v 
	gem -v  
	#/root/.rbenv/versions/1.8.7-p375/bin/bundle -v

tag-and-push: build
	../tag-and-push-to-gcrio.sh $(APPNAME) $(VERSION)

fix-permissions:
	sudo chown -R ricc /home/ricc/.config/

##############################################################################
# THESE WORK but I'm working ona  repeatable working pipeline.. bear with me.
##############################################################################

#run-v1.1-p3000:
#	docker run -p 3000:3000 -ti palladius/ricniftystore:v1.1

#debug-v1.1-p3000:
#	docker run -p 3000:3000 -ti palladius/ricniftystore:v1.1 bash

# CREATE the Prod database once:
#RAILS_ENV=production rake db:create
#RAILS_ENV=production rake db:seed
