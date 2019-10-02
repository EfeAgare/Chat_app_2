# Define the base image with FROM
FROM ruby:2.6.2-stretch  

# RUN is to install the app
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs 

# make /myrailsapp directory
RUN mkdir /myrailsapp

#  Set the working directory to /myrailsapp 
WORKDIR /myrailsapp


# add or copy the Gemfile in the application to the /myrailsapp/Gemfile
ADD Gemfile /myrailsapp/Gemfile
ADD Gemfile.lock /myrailsapp/Gemfile.lock

# install 
RUN gem install bundler:2.0.2
RUN bundle install

# Copy 
ADD . /myrailsapp