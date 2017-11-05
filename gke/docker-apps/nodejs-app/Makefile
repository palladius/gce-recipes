
DOCKER_VERSION = $(shell cat VERSION)


run-on-nodejs:
	node server.js

run-on-docker: build
	docker run nodejs-app  

build:
	docker build -t nodejs-app .  

debug: build
	docker run -it nodejs-app bash

run-p3009: build
	docker run -p 3009:80 nodejs-app

debug-p3009: build
	docker run -p 3009:80 -it nodejs-app bash

tag-and-push: build
	../tag-and-push-to-gcrio.sh nodejs-app $(DOCKER_VERSION)