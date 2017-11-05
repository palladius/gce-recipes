
VERSION = $(shell cat VERSION)
APPNAME = sleepy

build:
	docker build -t $(APPNAME) .  

run: build
	docker run $(APPNAME)  

debug: build
	docker run -it $(APPNAME) bash

run-p3009: build
	docker run -p 3009:80 $(APPNAME)

debug-p3009: build
	docker run -p 3009:80 -it $(APPNAME) bash

tag-and-push: build
	../tag-and-push-to-gcrio.sh $(APPNAME) $(VERSION)

