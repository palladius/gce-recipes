# Docker-compose

Questo e' una specie di k8s, c'e' anche un modo epr convertire d-c into k8s: `compose2kube`

https://stackoverflow.com/questions/37845715/can-kubernetes-be-used-like-docker-compose

# EntryPoint

NOta che questo mi ha incasinato la vita e quesata ptorebbe essere la risposta: https://stackoverflow.com/questions/30063907/using-docker-compose-how-to-execute-multiple-commands

You can use entrypoint here. entrypoint in docker is executed before the command while command is the default command that should be run when container starts. So most of the applications generally carry setup procedure in entrypoint file and in the last they allow command to run.

make a shell script file may be as docker-entrypoint.sh (name does not matter) with following contents in it.

    #!/bin/bash
    python manage.py migrate
    exec "$@"

in docker-compose.yml file use it with entrypoint: /docker-entrypoint.sh and register command as command: python manage.py runserver 0.0.0.0:8000 P.S : do not forget to copy docker-entrypoint.sh along with your code.