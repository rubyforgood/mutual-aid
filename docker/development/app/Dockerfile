FROM ruby:2.7.0-alpine

ARG APP_PORT=3000

RUN bundle config --global frozen 1
WORKDIR /usr/src/app

RUN apk add --update-cache postgresql-dev zlib build-base tzdata nodejs yarn

ENV RAILS_ENV='' \
    POSTGRES_HOST='' \
    POSTGRES_PASSWORD='' \
    POSTGRES_USER='postgres' \
    POSTGRES_DB='' \
    SECRET_KEY_BASE='' \
    EMAIL_PORT='' \
    EMAIL_HOST='' \
    EMAIL_FROM_ADDR='' \
    EMAIL_DEFAULT_URL_HOST=''

COPY Gemfile Gemfile.lock ./
COPY package.json yarn.lock ./
RUN bundle install
RUN yarn install

COPY . ./

EXPOSE ${APP_PORT}
ENV PORT ${APP_PORT}

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
