
VERSION = $(shell cat VERSION)
APPNAME = ruby-1.8.7 

build:
	docker build -t $(APPNAME) .

run-local: build
	docker run -it --rm $(APPNAME)

tag-and-push: build
	../tag-and-push-to-gcrio.sh $(APPNAME) $(VERSION)
