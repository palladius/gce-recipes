#!/bin/bash
# run-once-on-prod-mysql.sh

# SET UP PROD once:

@echo this is only needed once in prod:
RAILS_ENV=production rake db:setup
RAILS_ENV=production rake db:migrate
touch run-once-on-prod-mysql