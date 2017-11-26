# Found in: https://gist.github.com/formigarafa/474af0ce654389c2aabe34d9f0a0b881

FROM ubuntu:16.04

# With some help let's be clear!
MAINTAINER Riccardo Carlesso <riccardo.carlesso@gmail.com>

WORKDIR /root

RUN apt update
RUN apt upgrade -y
RUN apt install -y ruby-build autoconf subversion bison build-essential wget git
RUN apt build-dep -y ruby-sqlite3

# This fails :/ so I'll install the package without sources I'm afraid.
#RUN apt build-dep -y ruby2.3  
RUN apt install -y ruby2.3

ENV PATH /root/.rbenv/shims:$PATH
RUN rbenv install 1.8.7-p375
RUN rbenv local 1.8.7-p375
RUN gem install sqlite3

RUN gem install rake -v 0.8.7
RUN gem install mongrel
RUN gem install rails -v 2.3.18
RUN rbenv rehash

COPY VERSION /RUBY-VERSION.riccardo

WORKDIR /root

CMD bash
