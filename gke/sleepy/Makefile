
# creates SLEEPY app :)

up:
	kubectl create -f ./

down:
	kubectl delete deployment -l app=sleepy
	kubectl delete service -l app=sleepy
	kubectl delete pvc -l app=sleepy
	kubectl delete -f ./

status:
	kubectl get pods,rc,svc
