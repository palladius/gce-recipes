
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