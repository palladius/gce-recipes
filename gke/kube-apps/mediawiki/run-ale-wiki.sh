#!/bin/bash

source .env-priv.sh

echo 'SHOW TABLES;' | mysql -u $MYSQL_USER -p$MYSQL_PASS -h $MYSQL_HOST