
status:
	kubectl get pods | egrep "mysql|wordpress"
	kubectl get pv
	kubectl get secrets | grep mysql-pass
	kubectl get services wordpress

logs:
	kubectl  logs -lapp=wordpress
	kubectl  logs -lapp=mysql3


up:
	MYSQL_ROOT_PASSWORD=M4k3f1l3P4S5w0rd ./spin-up.sh

down:
	./spin-down.sh

purge: down
	@echo DELETING Persistent Disks too...
	./purge.sh

restart:
	make down
	sleep 1
	make up