
# https://github.com/palladius/septober
status:
	#kubectl get pods,rc,svc -L app -L version  -L tier
	kubectl get pods,svc -L app -L version -L tier --namespace riccardume

up:
	kubectl create -f ./


down:
	kubectl delete -f ./

logs:
	kubectl logs -f septober --namespace riccardume

restart:
	make down
	sleep 1
	make up


###########################
# docker inspiration: https://github.com/kstaken/dockerfile-examples

docker-run-local-3002:
	sudo docker run -it -p 3002:3000 --name=septober-v1-p3002 palladius/septober:v1 'cd /home/riccardo/git/septober/ && make run'

docker-build:
	@echo "Defer to github: palladius/septober"

