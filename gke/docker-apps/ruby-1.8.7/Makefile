
VERSION = $(shell cat VERSION)
APPNAME = ruby-1.8.7 

build:
	docker build -t $(APPNAME) .

run-local: build
	docker run -it --rm $(APPNAME)

tag-and-push: build
	../tag-and-push-to-gcrio.sh $(APPNAME) $(VERSION)

push-to-dockerhub:
	docker images | grep ruby
	docker tag -f ruby-1.8.7 palladius/ruby187:$(VERSION)
	docker tag -f ruby-1.8.7 palladius/ruby187
	docker push palladius/ruby187
	docker push palladius/ruby187:$(VERSION)
