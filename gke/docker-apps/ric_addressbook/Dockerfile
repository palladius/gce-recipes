FROM ruby-1.8.7 

MAINTAINER Riccardo Carlesso <riccardo.carlesso@gmail.com>

COPY ric_addressbook-files/ /var/www/ric_addressbook/

WORKDIR /var/www/ric_addressbook/

#  possibly git is not necessary
RUN apt-get -y install libgmp-dev git
RUN rbenv local 1.8.7-p375
RUN gem install bundler -v 1.16.0 --no-rdoc --no-ri

#RUN /root/.rbenv/versions/1.8.7-p375/bin/bundle install
#RUN rake db:seed

# Needed for PROD.. just use DEV DB and copy it :)
RUN cp db/development.sqlite3 db/production.sqlite3

EXPOSE 3000

CMD ["script/server", "-b", "0.0.0.0"]

