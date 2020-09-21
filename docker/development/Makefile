SHELL=/bin/bash -o pipefail

build:
	docker-compose up --build

logs:
	docker-compose logs

rspec:
	docker-compose run --rm app bin/rspec

prepare:
	docker-compose run --rm app db:prepare

seed:
	docker-compose run --rm -e SYSTEM_EMAIL=${SYSTEM_EMAIL}  -e SYSTEM_PASSWORD=${SYSTEM_PASSWORD} app rails db:prepare db:seed

seed_test:
	docker-compose run --rm app bin/rake db:seed RAILS_ENV=test

start:
	docker-compose up app

startd:
	docker-compose up -d

stop:
	docker-compose down

test:
	docker-compose run --rm app bin/test

webpack:
	docker-compose run --rm app bin/webpack-dev-server

wipe:
	docker-compose down --volumes --remove-orphans
