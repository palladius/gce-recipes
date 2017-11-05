
# creates SLEEPY app :)

status:
	kubectl get pods,rc,svc -L app -L version -L ns -L namespace # --namespace jenkins
	kubectl get pods -L app -L version -L ns -L namespace --namespace riccardume

# up BOTH v1/v2
up:
	kubectl create -f ./

# down BOTH v1/v2
down:
	kubectl delete deployment -l app=sleepy
	kubectl delete service -l app=sleepy
	kubectl delete pvc -l app=sleepy
	kubectl delete -f ./


up-sleepy-docker:
	kubectl create -f sleepy-docker.yaml
