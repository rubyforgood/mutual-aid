FROM ruby:2.7.0-alpine

RUN bundle config --global frozen 1
WORKDIR /usr/src/app

RUN apk add --update-cache postgresql-dev zlib build-base tzdata nodejs yarn

ENV RAILS_ENV= \
    POSTGRES_HOST= \
    POSTGRES_PASSWORD= \
    POSTGRES_USER=postgres \
    POSTGRES_DB= \
    SECRET_KEY_BASE= 

COPY Gemfile Gemfile.lock ./
COPY package.json yarn.lock ./
RUN bundle install
RUN yarn install

COPY . ./

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]