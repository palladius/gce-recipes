run-joomla-version.sh


giallo 'Runing joomla locally just tpo get version: echo ${JOOMLA_VERSION}'
docker run -it -p 8080:80 \
  -e JOOMLA_DB_HOST="104.197.195.148:3306" \
  -e JOOMLA_DB_USER="palladius-user" \
  -e JOOMLA_DB_PASSWORD="SitoPersonaleSuSpeckle" \
  -e JOOMLA_DB_NAME="palladiusdb" \
  joomla sh -c "echo \${JOOMLA_VERSION}"
