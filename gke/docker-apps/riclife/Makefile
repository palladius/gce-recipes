
VERSION = $(shell cat VERSION)
APPNAME = riclife
PRIVATEDB = /bin/true
FUNGE = funge


list:
	@cat Makefile

#riclife-files/config/smtp_gmail.yml:
#	@echo If this fails you need to create one yourself and put into secrets taking inspiration from smtp_gmail.yml.example file.
#	cp secrets/smtp_gmail.yml riclife-files/config/smtp_gmail.yml

riclife-files: 
	git clone https://github.com/palladius/riclife $(APPNAME)-files

build: $(APPNAME)-files 
	docker build -t $(APPNAME) .

run: build
	docker run $(APPNAME)  

run-debug: build
	docker run -it $(APPNAME) bash

run-p3009: build
	docker run -p 3009:80 $(APPNAME)

debug-p3009: build
	docker run -p 3009:80 -it $(APPNAME) bash

tag-and-push: build
	../tag-and-push-to-gcrio.sh $(APPNAME) $(VERSION)

# fixed a mnhouse
# $ docker commit -m "fixed rubies n stuff a manhouse" -a "A N Other" `docker ps -l -q` riclife:funge2
#sha256:57bee1f9ad6d6302d234a415587e33eb65210a091e2f8d8d73c931dd431c73b6
# https://docs.oracle.com/cd/E77565_01/E75728/html/section_c5q_n2z_fp.html
tag-and-push-funge:
	docker commit -m "fixed ruby and bundler a manouse" -a "A N Other"   `docker ps -l -q` riclife:$(FUNGE)	
	docker tag riclife:$(FUNGE) gcr.io/ric-cccwiki/riclife:$(FUNGE)
	gcloud docker -- push gcr.io/ric-cccwiki/riclife:$(FUNGE)

run-from-cloud-funge:
	@echo If it funge pls try: /root/riclife/script/server or console or dbconsole
	docker run -it gcr.io/ric-cccwiki/riclife:$(FUNGE) bash # try /root/
