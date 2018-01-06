

# only run this once:
# See https://docs.docker.com/compose/rails/#connect-the-database
# $ docker-compose run web rails new . --force --database=postgresql
# $ sudo chown -R $USER:$USER .
# $ docker-compose build
# change DB config for Postgres.

build-compose:
	docker-compose build


run-compose:
	docker-compose up

stop-compose:
	docker-compose down
	sudo rm tmp/pids/server.pid

# non capisco perche' ma la migrazione e' QUI e' LOCALE quindi non devo tenerne conto in CLI
# Figatissima!
#compose-add-scaffold:
#	# from: http://guides.rubyonrails.org/command_line.html
#	docker-compose run web rails generate scaffold HighScore game:string score:integer
#	docker-compose run web rails db:migrate
