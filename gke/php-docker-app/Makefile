
VERSION = $(shell cat code/VERSION)

build:
	docker build -t php-app .  

run: build
	docker run php-app  

debug: build
	docker run -it php-app bash

run-p3009: build
	docker run -p 3009:80 php-app

debug-p3009: build
	docker run -p 3009:80 -it php-app bash

tag-and-push: build
	../tag-and-push-to-gcrio.sh php-app $(VERSION)
