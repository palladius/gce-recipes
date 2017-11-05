# name: sleepy-docker
MAINTAINER Riccardo Carlesso
FROM ubuntu:latest

COPY simulate-long-workload.sh VERSION /

# so args can be sth like 3600
ENTRYPOINT /bin/bash ./simulate-long-workload.sh

#RUN /bin/bash -c -- ./simulate-long-workload.sh 10 'docker default 10secs'
RUN echo "To levergae this awesome container run withi argument like: ./simulate-long-workload.sh 3600 'test 123'"
