FROM ruby-1.8.7 

COPY pasta-files/ /var/www/pasta/

WORKDIR /var/www/pasta/

RUN apt-get -y install libgmp-dev git
RUN rbenv local 1.8.7-p375
RUN gem install bundler -v 1.16.0 --no-rdoc --no-ri
#RUN gem install will_paginate -v 2.3.11 --no-rdoc --no-ri
#RUN gem install hobo -v 1.0  --no-rdoc --no-ri
RUN /root/.rbenv/versions/1.8.7-p375/bin/bundle install
#RUN rake db:seed

EXPOSE 3000

CMD ["script/server", "-b", "0.0.0.0"]


#########################################
# Working locally:
# apt -y install vim
#RUN /root/.rbenv/versions/1.8.7-p375/bin/gem install bundler -v 1.16.0
#RUN /root/.rbenv/versions/1.8.7-p375/bin/bundle install
#RUN /root/.rbenv/versions/1.8.7-p375/bin/rake db:setup
#RUN rake db:setup
####
# make normal JSON in Gemfile
# /root/.rbenv/versions/1.8.7-p375/bin/bundle install
#RUN bundle install
#RUN ln -s /root/.rbenv/versions/1.8.7-p375/bin/bundle /usr/bin/
