FROM ruby:2.7.2-alpine

RUN apk add --update-cache openssl-dev build-base sqlite-dev


RUN gem install mailcatcher

EXPOSE 1080
EXPOSE 1025

CMD ["mailcatcher", "--foreground", "--ip", "0.0.0.0"]