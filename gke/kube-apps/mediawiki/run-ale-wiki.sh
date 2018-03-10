#!/bin/bash

source "env.sh"

_mysql() {
	 mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -H "$MYSQL_HOST" "$MYSQL_DATABASE"
}

echo mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -h "$MYSQL_HOST" "$MYSQL_DATABASE"
yellow "Tables:"
echo 'SHOW TABLES ;' | mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -h "$MYSQL_HOST" "$MYSQL_DATABASE"
yellow "DBs:"
echo 'SHOW DATABASES ;' | mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -h "$MYSQL_HOST" "$MYSQL_DATABASE"