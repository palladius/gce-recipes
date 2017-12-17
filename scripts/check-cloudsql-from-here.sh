#!/bin/bash

# DB in https://console.cloud.google.com/sql/instances/prod/overview?project=ric-cccwiki&duration=PT1H

echo "SHOW DATABASES ;" | mysql -u root -pezc0xGPCFJDBIaP5 -h 35.198.182.127

for DB in cat_list_rails_speckle gogliardia pasta riclife ricniftystore ; do
	echo "= Tables in $DB ="
	echo "USE $DB; SHOW TABLES ;" | mysql -u root -pezc0xGPCFJDBIaP5 -h 35.198.182.127 2>/dev/null
done

