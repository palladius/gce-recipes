FROM ruby-1.8.7 

COPY pasta-files/* /var/www/pasta/

WORKDIR /var/www/pasta/

# taking versions from Gemfile.lock:
RUN gem install  bundler -v 1.16.0
RUN rake db:setup

EXPOSE 3000

CMD ["script/server", "-b", "0.0.0.0"]