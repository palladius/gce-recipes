#!/bin/bash

# configuration common to everyone.

# nuovo utente pwd per palladius.it PROD
SPECKLEV2_PALLADIUS_DBCONFIG=" -e JOOMLA_DB_HOST=104.197.195.148:3306 -e JOOMLA_DB_USER=palladius-user -e JOOMLA_DB_PASSWORD=SitoPersonaleSuSpeckle -e JOOMLA_DB_NAME=palladiusdb "
# utenmte creato 20180102 per palladius.it v2 STAGING (db vuoto per ora.)
SPECKLEV2_JUMLA3_DBCONFIG=" -e JOOMLA_DB_HOST=104.197.195.148:3306 -e JOOMLA_DB_USER=jumla3user -e JOOMLA_DB_PASSWORD=DibbiVerginelloXOra -e JOOMLA_DB_NAME=palladiusdb "
