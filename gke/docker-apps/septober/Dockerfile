# LOCAL: FROM ruby-1.8.7 # doesnt work in automated workflows :(
# REMOTE from: https://hub.docker.com/r/palladius/ruby187/tags/

FROM palladius/ruby187

COPY septober-files/ /var/www/septober/
COPY private/config/database.yml /var/www/septober/config/

WORKDIR /var/www/septober/

RUN apt-get -y install libgmp-dev git
RUN apt-get -y install mysql-client libmysqlclient-dev
RUN rbenv local 1.8.7-p375
RUN gem install bundler -v 1.16.0 --no-rdoc --no-ri
##RUN gem install hobo -v 1.0  --no-rdoc --no-ri
#RUN gem install ZenTest -v '4.7.0'
RUN /root/.rbenv/versions/1.8.7-p375/bin/bundle install
#RUN rake db:seed

EXPOSE 3000

CMD ["script/server", "-b", "0.0.0.0"]

