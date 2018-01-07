#!/bin/bash

# copiato idea da: https://stackoverflow.com/questions/38089999/docker-compose-rails-best-practice-to-migrate

set -e

rake db:create
rake db:migrate

touch runnin-entrypoint.touch

exec "$@"
