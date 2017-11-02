
status:
	kubectl get pods -L app -L version -L pinco -L tier
	kubectl get pods --namespace jenkins

guestbook-create:
	kubectl create -f redis-php-guestbook/ # TODO

logs:
	kubectl logs -f septober-test-2855027742-wldlc

# Namespaces are used under jenkins/
prep:
	kubectl create ns riccardume
	kubectl create ns jenkins
	kubectl create ns demo
