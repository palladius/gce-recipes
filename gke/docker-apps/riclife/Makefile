
VERSION = $(shell cat VERSION)
APPNAME = riclife

list:
	@cat Makefile

riclife-files/config/smtp_gmail.yml:
	@echo If this fails you need to create one yourself and put into secrets taking inspiration from smtp_gmail.yml.example file.
	cp secrets/smtp_gmail.yml riclife-files/config/smtp_gmail.yml

riclife-files: 
	git clone https://github.com/palladius/riclife $(APPNAME)-files

build: $(APPNAME)-files riclife-files/config/smtp_gmail.yml
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
