# cant find it
#FROM ruby:2.3
# Defined in ../ruby-1.8.7/ ==> wOt?!??
FROM ruby-1.8.7 

COPY riclife-files/* /var/www/riclife/

# TODO Use SECRETS to get USER and PASS

WORKDIR /var/www/riclife/

# doesnt work
#RUN gem install --no-ri --no-rdoc bundler
# this works but installs newer bundler incompatible with r187 :/ ARGH!
#RUN apt -y install bundler
#RUN bundle install
#RUN rake gems:install # doesnt work

# taking versions from Gemfile.lock:
RUN gem install  bundler -v 1.16.0
#RUN gem install calendar_date_select -v 1.16.4
#RUN gem install icalendar -v 1.4.3
#RUN gem install contacts

RUN /root/.rbenv/versions/1.8.7-p375/bin/bundle install

RUN rake db:setup
EXPOSE 3000
CMD ["script/server", "-b", "0.0.0.0"]


################################################
# Brutta: https://hub.docker.com/_/rails/
#COPY Gemfile* ./
#COPY . .
