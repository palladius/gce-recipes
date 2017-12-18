#FROM palladius/ruby187
FROM ruby-1.8.7:latest

MAINTAINER Riccardo Carlesso <riccardo.carlesso@gmail.com>

# Public data
COPY riclife-files/              /var/www/riclife/
# Private data
COPY private/       /var/www/riclife/
COPY private/config/database.yml /var/www/riclife/config/

# needed for the /usr/bin/dot rendering of awesome "/friendships/update_dotsvg.png"
RUN apt -y install graphviz
RUN apt -y install mysql-client libmysqlclient-dev

WORKDIR /var/www/riclife/

RUN rbenv local 1.8.7-p375
RUN gem install bundler -v 1.16.0 --no-rdoc --no-ri
# Needed to run in production with MySQL
RUN gem install activerecord-mysql2-adapter --no-rdoc --no-ri

# final gem requires mysql
#RUN rbenv local 1.8.7-p375
#RUN gem install bundler -v 1.16.0 --no-rdoc --no-ri
#RUN gem install activerecord-mysql2-adapter --no-rdoc --no-ri

RUN /root/.rbenv/versions/1.8.7-p375/bin/bundle install

EXPOSE 3000



CMD ["script/server", "-b", "0.0.0.0"]


################################################
# Brutta: https://hub.docker.com/_/rails/
################################################
#RUN gem install calendar_date_select -v 1.16.4
#RUN gem install icalendar -v 1.4.3
#RUN gem install contacts
#RUN gem install geoip --no-rdoc --no-ri
#RUN rake gems:install

# Run once:
#RUN rake db:setup
