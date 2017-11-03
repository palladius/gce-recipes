
show:
	kubectl get pods,rc,svc -L app -L version -L tier

# set project_id TODO: ric-cccwiki
configure:
	kubectl config current-context
	kubectl config set-cluster ricc-prod
	kubectl config current-context

status:
	kubectl get pods,rc,svc -L app -L version -L tier
