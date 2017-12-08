
status:
	kubectl get pods -L app -L version -L tier
	kubectl get pods,rc,svc -L app -L version -L tier
	#kubectl get pods --namespace jenkins


create-loads-of-stuff:
	./kubectl-release-inferno.sh

logs:
	kubectl logs -f septober-test-2855027742-wldlc

# Namespaces are used under jenkins/
prep:
	kubectl create ns riccardume  # riccardo stuff: pasta, septober, ..
	kubectl create ns jenkins     # TODO
	kubectl create ns buridone    # lots of stuff together, demo, helloworlds, ..

run-proxy:
	kubectl proxy

show: status
list: status
