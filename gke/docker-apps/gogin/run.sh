#!/bin/bash

export GOARCH=amd64
export GOOS=linux
export GOPATH=$HOME/.go
#export GOROOT=$GOPATH
# export GOROOT=/usr/lib/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

#go get gopkg.in/gin-gonic/gin.v1

go run ./main.go
