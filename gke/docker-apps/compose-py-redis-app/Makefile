
DOCKER_VERSION = $(shell cat VERSION)
APPNAME = pyredis

help:
	@echo Try these:
	@echo docker-compose up
	@echo curl http://localhost:5000/

#run-local-non-funge:
#	@echo "This wont work as it also needs Redis!"
#	pip install -r requirements.txt
#	python app.py

run-on-docker: build
	docker run $(APPNAME)

run-docker-compose:
	docker-compose up

build:
	docker build -t $(APPNAME) .  

debug: build
	docker run -it $(APPNAME) bash

run-p3009: build
	docker run -p 3009:80 $(APPNAME)

debug-p3009: build
	docker run -p 3009:80 -it $(APPNAME) bash

tag-and-push: build
	../tag-and-push-to-gcrio.sh $(APPNAME) $(DOCKER_VERSION)