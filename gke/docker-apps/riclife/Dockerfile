#FROM ruby-1.8.7 # Defined in ../ruby-1.8.7/ ==> wOt?!??
FROM palladius/ruby187

MAINTAINER Riccardo Carlesso <riccardo.carlesso@gmail.com>

COPY private/*                   /var/www/riclife/
COPY riclife-files/*             /var/www/riclife/
#COPY private/config/database.yml /var/www/riclife/config/

WORKDIR /var/www/riclife/

# needed for the /usr/bin/dot rendering of awesome "/friendships/update_dotsvg.png"
RUN apt -y install graphviz
RUN apt -y install mysql-client libmysqlclient-dev

# taking versions from Gemfile.lock:
RUN gem install bundler -v 1.16.0 --no-rdoc --no-ri
RUN gem install activerecord-mysql2-adapter --no-rdoc --no-ri
RUN /root/.rbenv/versions/1.8.7-p375/bin/bundle install
#RUN rake db:setup

EXPOSE 3000

CMD ["script/server", "-b", "0.0.0.0"]


################################################
# Brutta: https://hub.docker.com/_/rails/
################################################
#RUN gem install calendar_date_select -v 1.16.4
#RUN gem install icalendar -v 1.4.3
#RUN gem install contacts
