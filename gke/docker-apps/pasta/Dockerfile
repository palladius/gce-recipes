FROM ruby-1.8.7 

COPY pasta-files/ /var/www/pasta/

WORKDIR /var/www/pasta/

RUN apt-get -y install libgmp-dev git

# taking versions from Gemfile.lock:
RUN rbenv local 1.8.7-p375
RUN gem install bundler -v 1.16.0 --no-rdoc --no-ri
#RUN bundle install

####
# make normal JSON in Gemfile
# /root/.rbenv/versions/1.8.7-p375/bin/bundle install
RUN /root/.rbenv/versions/1.8.7-p375/bin/bundle install
RUN rake db:seed

EXPOSE 3000

CMD ["script/server", "-b", "0.0.0.0"]


#########################################
# Working locally:
# apt -y install vim
#RUN /root/.rbenv/versions/1.8.7-p375/bin/gem install bundler -v 1.16.0
#RUN /root/.rbenv/versions/1.8.7-p375/bin/bundle install
#RUN /root/.rbenv/versions/1.8.7-p375/bin/rake db:setup
#RUN rake db:setup
