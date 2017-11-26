#FROM ruby-1.8.7 
FROM palladius/ruby187

MAINTAINER Riccardo Carlesso <riccardo.carlesso@gmail.com>

COPY ricniftystore-files/ /var/www/ricniftystore/
COPY private/config/database.yml /var/www/ricniftystore/config/

WORKDIR /var/www/ricniftystore/

#  possibly git is not necessary
RUN apt-get -y install libgmp-dev git

# Needed to run in production with MySQL
# to run MySQL in prod :) See https://www.digitalocean.com/community/tutorials/how-to-use-mysql-with-your-ruby-on-rails-application-on-ubuntu-14-04
RUN apt-get -y install mysql-client libmysqlclient-dev
RUN rbenv local 1.8.7-p375
RUN gem install bundler -v 1.16.0 --no-rdoc --no-ri
# Needed to run in production with MySQL
RUN gem install activerecord-mysql2-adapter --no-rdoc --no-ri

# REMOVEME :)
#RUN /root/.rbenv/versions/1.8.7-p375/bin/bundle install
#RUN rake db:seed


# Needed for PROD.. just use DEV DB and copy it :)
RUN cp db/development.sqlite3 db/production.sqlite3


EXPOSE 3000

# run in DEV :) (not prod). Maybe I should change it to prod by dflt since it has MySQL installed now?
CMD ["script/server", "-b", "0.0.0.0"]
