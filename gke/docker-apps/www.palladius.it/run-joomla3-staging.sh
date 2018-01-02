#!/bin/bash

# run-joomla3-staging.sh
  # docs: https://hub.docker.com/_/joomla/

source "env.sh"

giallo "Runing joomla locally: open http://localhost:8080/"
docker run -it -p 8080:80 $SPECKLEV2_JUMLA3_DBCONFIG joomla


