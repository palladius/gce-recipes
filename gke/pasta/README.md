
docker repo: https://hub.docker.com/r/palladius/pasta/


# Hack

docker run -it palladius/pasta:v0.2alpha bash

cd /root/git/pasta
echo rake / bundler / hack...
Try this:

$ docker run -p 3000:3000 -ti palladius/pasta:v1.1
$ cd /root/git/pasta
$ RAILS_ENV=production script/server

open http://localhost:3000/sauces

