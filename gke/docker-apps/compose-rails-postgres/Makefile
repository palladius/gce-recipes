

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

compose-add-scaffold:
	docker-compose run web rails generate scaffold HighScore game:string score:integer
	docker-compose run web rails db:migrate
