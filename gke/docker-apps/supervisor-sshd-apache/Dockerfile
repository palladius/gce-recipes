# Installing Supervisor
# We can now install our SSH and Apache daemons as well as Supervisor in our container.
FROM ubuntu:14.04

MAINTAINER riccardo.carlesso@gmail.com

ENV RICCARDO_SUPERVISORD_VER 1.2
ENV RICCARDO_SUPERVISORD_DESC \
  "Copied from internet to launch two daemons (ssh/22 + apache/80), I just added a demential netcat on port 10k"

RUN apt-get update
RUN apt-get install -y openssh-server apache2 supervisor
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

RUN useradd -ms /bin/bash cielcio
RUN echo 'cielcio:D0ck3r1nsp3ct0r' | chpasswd
RUN echo "$RICCARDO_SUPERVISORD_VER" > /riccardo_supervisord_version.txt

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22 80 10000

CMD ["/usr/bin/supervisord"]
