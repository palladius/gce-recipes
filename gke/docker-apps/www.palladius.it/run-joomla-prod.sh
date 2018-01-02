#!/bin/bash

LATEST_VER=3.8.3

source "env.sh"
#docker run --name joomla-specklev2 -d joomla \
#giallo "Runing joomla locally: open http://localhost:8080/"
set -x


docker run -it -p 8080:80 $SPECKLEV2_PALLADIUS_DBCONFIG joomla

#docker run -it -p 8080:80 \
 # -e JOOMLA_DB_HOST="104.197.195.148:3306" \
  #-e JOOMLA_DB_USER="palladius-user" \
  #-e JOOMLA_DB_PASSWORD="SitoPersonaleSuSpeckle" \
  #-e JOOMLA_DB_NAME="palladiusdb" \
  #joomla 
  # docs: https://hub.docker.com/_/joomla/

