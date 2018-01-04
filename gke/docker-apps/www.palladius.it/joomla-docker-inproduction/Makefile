

setup:
	mkdir -p /srv/docker/smartprojects/mysql
	mkdir -p /srv/docker/smartprojects/joomla_www
	mkdir -p /srv/docker/smartprojects/phpmyadmin/sessions
	touch setup

start: setup
	docker-compose -f docker-compose-joomla.yml up 

stop:
	docker-compose -f docker-compose-joomla.yml stop
rm:
	docker-compose -f docker-compose-joomla.yml rm -f