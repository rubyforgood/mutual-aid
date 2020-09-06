# Setting Up Development

(continued from [README.md](README.md))

This is a Ruby on Rails 6.0 application with Vue + Webpack included.

To get started developing on your machine, you'll need the following tools installed:

* ruby 2.7
* bundler 2+ (ruby package manager)
* node 10+
* yarn 1.16+ (node package manager)

This project uses webpacker to bundle front end assets, including:
* vue 0.8.2+
* bulma css 2.6.11+

## Setting up services
Some choices for how to run services in your development environment:
* If you decide to use Docker:
    * [Docker](#development-with-docker)
* If you want to install local services on your development host:
    * PostgreSQL 9.5+
    * Mailcatcher 0.7.1

## Setting up Ruby and Bundler

The easiest way to manage different installations of Ruby (we think) is with [rbenv](https://github.com/rbenv/rbenv). After following the installation instructions on the rbenv repo and restarting your terminal, you'll be able to run `rbenv install` in the root directory of the repository. rbenv will handle installing Ruby and switching to it for you when you enter the repo (so no need to worry about your other Ruby installs!) After that, run `gem install bundler` and you'll be all set to run `bundle install`.

If you run into a problem where your bundle install says you're on an older version of bundler than what's in the lockfile, run `gem update --system` to update RubyGems, then `gem install bundler:[latest-version-you-want], e.g. gem install bundler:2.1.2]`

Depending on your system, you might have trouble building the `pg` gem, probably due to a missing `libpq-fe.h`. To get the necessary libraries installed:
* For Mac (Homebrew): `brew install postgresql`
* Debian/Ubuntu: `sudo apt-get install libpq-dev`
* On Enterprise Linux (CentOS/RHEL/Fedora/Amazon Linux/Sci Linux): `yum install postgresql-devel`

## Setting up Node with Yarn

The easiest way to manage different installations with node.js is with [nvm](https://github.com/nvm-sh/nvm). After following the installation instructions, type `nvm install` to install and run the right version of node.js.

You'll also need Yarn, a package manager for node.js. To install that:
* For Mac (Homebrew): `brew install yarn`
* Debian/Ubuntu:
```
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn
```
* On Enterprise Linux (CentOS/RHEL/Fedora/Amazon Linux/Sci Linux):
```
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo yum install yarn
```

## Setting up Heroku (and using it for development)

The Rails and webpack processes can be launched with Heroku, if you choose to go that route. You can install Heroku Local using [these instructions](https://devcenter.heroku.com/articles/heroku-cli).

## Setting up other hosting

(If you've done this, please submit a PR so we can include instructions here!)


## Environment variables

We've used the [dotenv](https://github.com/bkeepers/dotenv) gem to reference .env files in the main project level of the repo. Check out their README!
We've provided example data, but please change them for your team, and, per their repo, you can save specific env files per environment, 
e.g. (`.env.development.local`, `.env.text.local`). All of these are already in the gitignore, but we've kept `.env` in there bc `circleci` needs it.

Remember to configure environment variables in Heroku or wherever you deploy! Only the development environment uses `.env`


## Running the App!

First, make sure local services are running

### Starting Local Services

#### ... with individually installed services

Ensure Postgres is running. We recommend Postgres.app for macOS if you don't already have it installed.

Mailcatcher cannot be bundled, for that reason we must use:

```
$ gem install mailcatcher
```

To get the MailCatcher gem's mail server up run:

```
$ mailcatcher
Go to http://localhost:1080/
Send mail through smtp://localhost:1025
```

Note: You only need mailcatcher if you're interested doing a lot of work on emails in the development environment. (They'll still be visible in the server log, but mailcatcher makes mailer work SO much easier.)

### Run the App Locally

Then, to run the app locally,
```
$ bundle && yarn
$ bin/rake db:rebuild_and_seed_dev
$ bin/rails s # or, rails s -p 9000 (or whatever port you want to use that's not the default 3000)
```

In a separate terminal:
```
$ bin/webpack-dev-server
```

Note about deprecation warnings. Ruby 2.7 deprecated some commonly used syntax so our codebase currently spits out a _lot_ of warnings.
It will take some time for all our gems to get caught up, so in the meantime you might consider turning off deprecation warnings.
There are [several ways](https://www.andrewm.codes/posts/hiding-ruby-2-7-deprecation-warnings-in-rails-6-2mil/) to do this.
An alternative to the methods listed in the artice is to create an alias `alias nodep='export RUBYOPT="-W:no-deprecated"'`, giving
you the flexibility to toggle warnings in each terminal session as appropriate.

### Run tests
See [TESTING.md](TESTING.md).


## Development with Docker

The application includes a pre-configured [docker-compose](https://docs.docker.com/compose/) environment. This environment includes two containers, which together deploy the application and a postgres database for it to connect to.

To get started using the application with docker,
1. Install [Docker](https://www.docker.com/get-started)
2. Install [docker-compose](https://docs.docker.com/compose/install/)
3. Clone the repository, and open the repository folder in your favorite command line or terminal application.
4. From within the repository, navigate to the `/docker/development` folder. If you are in the right folder, you will see a file named `docker-compose.yml`.
5. Run
   ```bash
   docker-compose run app '/usr/local/bin/rake' secret \
    | echo "SECRET_KEY_BASE=$(tail -1 -)" > .env
   ```
   to give rails the information it needs to be able to launch
6. Now you should be able to run `docker-compose up -d`. This will start the application in daemon mode, which means that the server will keep running in the background. If you navigate to  `localhost:3000` in your browser, you will see an error. This is normal, and it means that you still need to setup the database.
7. To setup the database, you can run
  ```bash
  docker-compose run \
    -e SYSTEM_EMAIL="theemailyouwanttouse@example.com" \
    -e SYSTEM_PASSWORD="ThePasswordYouWantToUse" \
    app rails db:prepare db:seed
  ```
  This will setup the database and create a default admin user with the email and password as specified by the `SYSTEM_EMAIL` and `SYSTEM_PASSWORD` environment variables you passed to `docker-compose` with the `-e` option. If you don't want to create the default user, you can just run `docker-compose run app db:prepare` and create the account using the sign up option on the website.

8. You should now be able to reload `localhost:3000` in your browser. If everything went well, the website should appear and be functional. You can sign in using the email and password you set in the previous step. This docker compose also setups an a `mailcatcher` server, which you can access at `localhost:1080`. All emails will be delivered to mailcatcher, which should allow you to setup user accounts.

**NOTE** Do not use this method in production! This is for **testing & development only** the configuration used with in this docker-compose file is highly insecure and should never be exposed to the public internet.

Note that if you are developing this application, running `docker-compose up` a second time after you have made changes may not update the version of the application deployed by `docker-compose`. To ensure that `docker-compose` builds a new image that includes you changes, run `docker-compose up --build` instead.

Also, if you would like docker-compose to run in daemon mode (which means that it will exit once the images have been set up and the application starts running) you may use `docker-compose up -d`. This will not show you any logging output from the application, however, and you will not be able to exit the application directly. To view logs when docker-compose is running in daemon mode, use `docker-compose logs`. To stop the application and all its services, run `docker-compose down`.

**NOTE** the application will save its state between successive invocations of `docker-compose up --build`. This means that if you make changes to the database - for example by adding content or users - then those changes will persist the next time you start the application with `docker-compose`. You can wipe all the state of the application and all the services (including the postgres database) attached to it by running `docker-compose down --volumes --remove-orphans`. In particular, you may need to do this if you are making breaking changes to the database structure, or if you have corrupted something somehow. However, do be careful, because this will delete **all** the state saved in the application and database - and there is no way to retrieve it. So make sure you back up anything you want to save before running the command.


([Return to README.md](README.md))
