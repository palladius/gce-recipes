# Found in: https://gist.github.com/formigarafa/474af0ce654389c2aabe34d9f0a0b881

# docker build -t ruby-1.8.7 .
# docker run -it --rm ruby-1.8.7

FROM ubuntu:16.04
WORKDIR /root

RUN apt update
RUN apt upgrade -y
RUN apt install -y ruby-build autoconf subversion bison
RUN apt install -y mecab mecab-ipadic-utf8 wget
RUN apt build-dep -y ruby2.3 ruby-sqlite3 ruby-mecab
# The command '/bin/sh -c apt build-dep -y ruby2.3 ruby-sqlite3 ruby-mecab' returned a non-zero code: 100


ENV PATH /root/.rbenv/shims:$PATH
RUN rbenv install 1.8.7-p375
RUN rbenv local 1.8.7-p375
RUN gem install sqlite3

RUN gem install rake -v 0.8.7
RUN gem install mongrel
RUN gem install rails -v 2.3.18
RUN rbenv rehash

RUN wget http://mecab.googlecode.com/files/mecab-ruby-0.994.tar.gz
RUN tar xf mecab-ruby-0.994.tar.gz
WORKDIR /root/mecab-ruby-0.994
RUN gem build mecab-ruby.gemspec
RUN gem install mecab-ruby

WORKDIR /root
CMD bash
