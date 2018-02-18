

APPNAME = gogin

install-once:
	@echo "If GOPATH is unset, try: export GOPATH=$HOME/go"
	go get gopkg.in/gin-gonic/gin.v1
	touch install-once

compile: 
	CGO_ENABLED=0 GOOS=linux go build -a --ldflags="-s" --installsuffix cgo -o webapp
	docker build -t $(APPNAME):v1 .  

run: compile
	./run.sh