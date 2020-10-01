FROM ruby:2.7.0-alpine as base

WORKDIR /usr/src/app

RUN apk add --update-cache postgresql-dev zlib build-base tzdata nodejs yarn

ENV BUNDLE_PATH='/usr/local/bundle' \
  RAILS_ENV='' \
  POSTGRES_HOST='' \
  POSTGRES_PASSWORD='' \
  POSTGRES_USER='postgres' \
  POSTGRES_DB='' \
  EMAIL_HTTP_PORT='' \
  EMAIL_SMTP_PORT='' \
  EMAIL_HOST='' \
  EMAIL_FROM_ADDR='' \
  EMAIL_DEFAULT_URL_HOST=''

COPY Gemfile Gemfile.lock ./
COPY package.json yarn.lock ./
RUN bundle install
RUN yarn install
