
# creates SLEEPY app :)

# up BOTH v1/v2
up:
	kubectl create -f ./

# down BOTH v1/v2
down:
	kubectl delete deployment -l app=sleepy
	kubectl delete service -l app=sleepy
	kubectl delete pvc -l app=sleepy
	kubectl delete -f ./

status:
	kubectl get pods,rc,svc -L app -L version
