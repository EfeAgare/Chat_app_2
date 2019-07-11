FROM ruby:2.6.2-stretch
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myrailsapp
WORKDIR /myrailsapp

ADD Gemfile /myrailsapp/Gemfile
ADD Gemfile.lock /myrailsapp/Gemfile.lock
RUN gem install bundler:2.0.2
RUN bundle install
ADD . /myrailsapp