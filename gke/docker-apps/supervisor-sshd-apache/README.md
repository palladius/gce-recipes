
Supervisor ti consente di far partire piu' di uno script alla volta.


See https://docs.docker.com/articles/using_supervisord/

Note: on Mac OS X do this to test your curl:

	docker-ip() {
		boot2docker ip 2> /dev/null
	}

Riesumatoi nel 2018.

Nota che puoi fare:

    make run
    ssh localhost -p 22022 -l cielcio # pwd nel Dockerfile
