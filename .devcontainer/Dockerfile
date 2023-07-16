FROM ruby:alpine3.18

RUN apk --update add g++ make python3 gcompat libstdc++ curl

ENV INSTALL_PATH /whether_the_weather
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

ARG RAILS_ENV
ENV RACK_ENV=$RAILS_ENV

COPY . ./

RUN gem install bundler
RUN if [[ "$RAILS_ENV" == "production" ]]; then bundle install --without development test; else bundle install; fi
