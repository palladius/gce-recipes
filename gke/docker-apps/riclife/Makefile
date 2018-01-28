
VERSION = $(shell cat VERSION)
APPNAME = riclife
PRIVATEDB = /bin/true
FUNGE = funge
LOCAL_PORT = 3009

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

run-local-debug: build
	docker run -it -p 0.0.0.0:$(LOCAL_PORT):3000 $(APPNAME) bash

run-p$(LOCAL_PORT)-dev: build
	docker run -p $(LOCAL_PORT):80 $(APPNAME) script/server

run-p$(LOCAL_PORT)-prod: build
	docker run -p $(LOCAL_PORT):80 $(APPNAME) RAILS_ENV=production script/server

#run-debug-p$(LOCAL_PORT): build
#	docker run -p $(LOCAL_PORT):80 -it $(APPNAME) bash

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

run-once-on-prod-mysql:
	./run-once-on-prod-mysql.sh

run-cloud-works:
	docker run -p 3000:3000 -it gcr.io/ric-cccwiki/riclife:funge  /root/riclife/script/server