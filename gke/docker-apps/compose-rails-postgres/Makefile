

# only run this once:
# See https://docs.docker.com/compose/rails/#connect-the-database
# $ docker-compose run web rails new . --force --database=postgresql
# $ sudo chown -R $USER:$USER .
# $ docker-compose build
# change DB config for Postgres.

PROJECT_TAG = ric180107

build-compose:
	docker-compose -p $(PROJECT_TAG) build

run-compose: build-compose
	docker-compose -p $(PROJECT_TAG) up

stop-compose:
	docker-compose -p $(PROJECT_TAG) down
	sudo rm tmp/pids/server.pid

# https://github.com/docker/compose/issues/2324
migratedb:
	#docker-compose -p $(PROJECT_TAG) run web rake db:create
	#docker-compose -p $(PROJECT_TAG) run web rake db:setup
	docker-compose -p $(PROJECT_TAG) run web rake db:create db:migrate db:seed

install-deps-locally: 
	@yellow Riccardo this is needed if you want to install LOCALLY and dirty your OS with Postgres and gems and stuff...
	sudo apt-get install postgresql postgresql-contrib libpq-dev
	bundle install

# non capisco perche' ma la migrazione e' QUI e' LOCALE quindi non devo tenerne conto in CLI
# Figatissima!
#compose-add-scaffold:
#	# from: http://guides.rubyonrails.org/command_line.html
#	docker-compose run web rails generate scaffold HighScore game:string score:integer
#	docker-compose run web rails db:migrate

test-migration:
	echo HighScore.all | rails console

debug:
	docker-compose -p $(PROJECT_TAG) run web bash


withindocker-test-db:
	@echo Databases:
	echo '\l' | psql -h db -Upostgres myapp_development 
#	echo 'SELECT * FROM pg_catalog.pg_tables;'| psql -h db -Upostgres myapp_development | grep -v pg_catalog
	@echo Tables:
	echo '\dt' | psql -h db -Upostgres myapp_development 
 
