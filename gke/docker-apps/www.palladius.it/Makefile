
VERSION = $(shell cat VERSION)
APPNAME = www.palladius.it-staging

PALLADIUS_CONFIG = -e JOOMLA_DB_HOST="104.197.195.148:3306" -e JOOMLA_DB_USER="palladius-user" -e JOOMLA_DB_PASSWORD="SitoPersonaleSuSpeckle" -e JOOMLA_DB_NAME="palladiusdb" 
BRANDNEW_CONFIG = TODO

#joomla sh -c "echo \${JOOMLA_VERSION}"


#build: $(APPNAME)-files
#	docker build -t $(APPNAME) .  

build:
	docker build -t $(APPNAME) .  

run: build
	docker run -p 8080:80 $(APPNAME) 

debug: build
	docker run -it -p 8080:80 $(APPNAME) bash

dockercompose-setup:
	#mkdir -p /srv/docker/riccardojumlaproject/mysql
	#mkdir -p /srv/docker/riccardojumlaproject/joomla_www
	#mkdir -p /srv/docker/riccardojumlaproject/phpmyadmin/sessions
	touch dockercompose-setup

dockercompose-start-jumla-mysql-phpmyadmin: dockercompose-setup
	docker-compose -f docker-compose-joomla.yml up 

run-prova-del-cacchio:
	docker run --name joomla-latest -d joomla

run-joomla-palladius-su-specklev2:
	docker run -it $(PALLADIUS_CONFIG) -p 8080:80 joomla

joomla-version:
	docker run -it -p 8080:80 $(PALLADIUS_CONFIG) joomla sh -c "echo \${JOOMLA_VERSION}"

#run-p3009: build
#	docker run -p 3009:80 $(APPNAME)

#debug-p3009: build
#	docker run -p 3009:80 -it $(APPNAME) bash

#tag-and-push: build
#	../tag-and-push-to-gcrio.sh $(APPNAME) $(VERSION)

$(APPNAME)-files:
	git clone git@bitbucket.org:palladius/www.palladius.it.git $(APPNAME)-files

docker-compose-up:
	docker-compose -f docker-compose-joomla.yml up 

