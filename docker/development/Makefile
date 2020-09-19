SHELL=/bin/bash -o pipefail

build:
	docker-compose up --build

logs:
	docker-compose logs

rspec:
	docker-compose run app bin/rspec

prepare:
	docker-compose run app db:prepare

seed:
	docker-compose run -e SYSTEM_EMAIL=${EMAIL}  -e SYSTEM_PASSWORD=${PASSWORD} app rails db:prepare db:seed

seed_test:
	docker-compose run app bin/rake db:seed RAILS_ENV=test

start:
	docker-compose up

startd:
	docker-compose up -d

stop:
	docker-compose down

test:
	docker-compose run app bin/test

webpack:
	docker-compose run app bin/webpack-dev-server

wipe:
	docker-compose down --volumes --remove-orphans
