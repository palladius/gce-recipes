# name: sleepy-docker
FROM ubuntu:latest

MAINTAINER Riccardo Carlesso

COPY simulate-long-workload.sh VERSION /

# so args can be sth like 3600
#ENTRYPOINT /bin/bash ./simulate-long-workload.sh
ENTRYPOINT  /bin/bash 

#RUN /bin/bash -c -- ./simulate-long-workload.sh 10 'docker default 10secs'
RUN echo "[RUN] Usage: ./simulate-long-workload.sh 3600 'test 123'"
RUN echo "[RUN] Hello docker!"

CMD [ "./simulate-long-workload.sh" "10" "easy-peasy-10sec-dflt" ]
