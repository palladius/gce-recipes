
VERSION = $(shell cat VERSION)
APP = supervisord

build:
	docker build -t palladius/supervisord:$(VERSION) .
	docker build -t $(APP):$(VERSION) .

#run-old:
#	docker run -P palladius/supervisord:$(VERSION)

run: build
	docker run -p 22022:22 -p 8080:80 -p 10000:10000 palladius/supervisord:$(VERSION)

run-shell:
	docker run -Pit palladius/supervisord:$(VERSION) bash

push:
	docker push palladius/supervisord:$(VERSION)

tag-and-push: build
	../tag-and-push-to-gcrio.sh $(APP) $(VERSION)
