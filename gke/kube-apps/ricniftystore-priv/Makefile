
describe:
	kubectl describe pod ricniftystore-mysql

up:
	kubectl create -f .


pod-up:
	echo Only bring up the app.. POD
	kubectl create -f ricniftystore.yaml

lb-up:
	echo bring up only LB...
	kubectl create -f niftystore-lb-svc.yaml

down:
	kubectl delete -f .

