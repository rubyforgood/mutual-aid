SHELL=/bin/bash -o pipefail

build:
	docker-compose up --build

logs:
	docker-compose logs

prepare:
	docker-compose run --rm app db:prepare

seed:
	docker-compose run --rm app bin/rake db:prepare db:seed

seed_test:
	docker-compose run --rm app bin/rake db:seed RAILS_ENV=test

start:
	docker-compose up app

startd:
	docker-compose up app -d

stop:
	docker-compose down

test:
	docker-compose run --rm app bin/test

rspec:
	docker-compose run --rm app bin/rspec

mocha:
	docker-compose run --rm app yarn test

mochaw:
	docker-compose run --rm app yarn test -w

webpack:
	docker-compose run --rm app bin/webpack-dev-server

wipe:
	docker-compose down --volumes --remove-orphans
