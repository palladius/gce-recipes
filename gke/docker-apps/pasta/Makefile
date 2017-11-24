
VERSION = $(shell cat VERSION)
APPNAME = pasta

# https://hub.docker.com/r/palladius/pasta/

pasta-files: 
	git clone https://github.com/palladius/pasta $(APPNAME)-files

build: $(APPNAME)-files
	docker build -t $(APPNAME) .

run: build
	docker run -it palladius/$(APPNAME):$(VERSION) bash

debug-v.2alpha:
	docker run -it palladius/pasta:v0.2alpha bash

run-v1.1-p3000:
	docker run -p 3000:3000 -ti palladius/pasta:v1.1

debug-v1.1-p3000:
	docker run -p 3000:3000 -ti palladius/pasta:v1.1 bash