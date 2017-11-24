#FROM ruby:2.3
FROM ruby-1.8.7

COPY riclife-files/* /var/www/riclife/

# TODO Use SECRETS to get USER and PASS

WORKDIR /var/www/riclife/
RUN bundle install
RUN rake db:setup
EXPOSE 3000
CMD ["script/server", "-b", "0.0.0.0"]


################################################
# Brutta: https://hub.docker.com/_/rails/
#COPY Gemfile* ./
#COPY . .
