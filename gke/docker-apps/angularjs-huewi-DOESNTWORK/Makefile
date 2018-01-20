
DOCKER_VERSION = $(shell cat VERSION)
# Hue Web Interface: https://github.com/ArndBrugman/huewi
APP_NAME = huewi-nodejs

run-on-nodejs: hue-files
	node hue-files/index.html

run-on-docker: build
	docker run $(APP_NAME)  

build: hue-files
	docker build -t $(APP_NAME) . 

debug: build
	docker run -it $(APP_NAME) bash

run-p3007: build
	docker run -p 3007:80 $(APP_NAME)

debug-p3007: build
	docker run -p 3007:80 -it $(APP_NAME) bash

tag-and-push: build
	../tag-and-push-to-gcrio.sh $(APP_NAME) $(DOCKER_VERSION)

hue-files:
	git clone https://github.com/ArndBrugman/huewi $(@)