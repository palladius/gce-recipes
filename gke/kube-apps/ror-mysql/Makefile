
deploy: tearup

tearup:
	kubectl create -f railsapp-secrets.yaml
	kubectl create -f railsapp-deployment.yaml
	kubectl create -f railsapp-service.yaml

teardown:
	kubectl delete -f ./

show:
	kubectl get secrets,deployments,pods