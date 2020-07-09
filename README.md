[![CircleCI](https://circleci.com/gh/maebeale/mutual-aid.svg?style=svg)](https://circleci.com/gh/maebeale/mutual-aid)

# Who we are:

We are devs committed to making mutual aid manageable and longstanding, so as to build, support, and strengthen resilient communities.

We aim to support people in working smarter, not harder.

This is not intended to be strictly a "product" -- we will be in partnership with specific mutual aid groups to solicit feedback and support their operations, with a nod to all mutual aid groups and administrative best practices.

The idea is that each group -- or cluster of groups -- would own their database and "instance" of this software, rather than there becoming one large/shared database (as is the case with products). This is to protect privacy, and to prioritize locality.

Ideally mutual aid networks will have their own tech teams, but we will provide initial support as capacity permits.


# Background
Mutual aid is not new. If it is new to you, please check out the history of mutual aid in your neighborhood or region, as likely you will find mentors and partners ready to accept your help. There are most likely leaders of color in your area. Please see if there are ways to support them before creating your own new network.

There is plenty of research to be done, and national and regional networks to connect in to.

If you have any question of us source code maintainers, please feel free to reach out in the #mutualaid channel in Ruby for Good Slack (we're affiliated) or connect with us through Github.


# Contributing

Visit our [CONTRIBUTING.md](https://github.com/maebeale/mutual-aid-app/blob/master/CONTRIBUTING.md) file for more information on making your contribution. We look forward to it!


# Setting Up Development

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
    * Redis 4+
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

## Setting up Heroku

The Rails and webpack processes can be launched with Heroku, if you choose to go that route. You can install Heroku Local using [these instructions](https://devcenter.heroku.com/articles/heroku-cli).

## Setting up other hosting
(If you've done this, please submit a PR so we can include instructions here!)


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
$ bundle install
$ yarn install
$ bin/rake db:rebuild_and_seed_dev
$ bin/rails s # or, rails s -p 9000 (or whatever port you want to use that's not the default 3000)
```

In development, webpacker runs a separate server to support automatic hot-swapping.
This is only necessary when working on pages containing vue code, but will also speed up initial page loads on other pages.
Run this in a separate terminal.
```
$ bin/webpacker-dev-server
```

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

**NOTE** Do not use this method in production! This is for **testing & development only* the configuration used with in this docker-compose file is highly insecure and should never be exposed to the public internet.

Note that if you are developing this application, running `docker-compose up` a second time after you have made changes may not update the version of the application deployed by `docker-compose`. To ensure that `docker-compose` builds a new image that includes you changes, run `docker-compose up --build` instead.

Also, if you would like docker-compose to run in daemon mode (which means that it will exit once the images have been set up and the application starts running) you may use `docker-compose up -d`. This will not show you any logging output from the application, however, and you will not be able to exit the application directly. To view logs when docker-compose is running in daemon mode, use `docker-compose logs`. To stop the application and all its services, run `docker-compose down`.

**NOTE** the application will save its state between successively invocations of `docker-compose up --build`. This means that if you make changes to the database - for example by adding content or users - then those changes will persist the next time you start the application with `docker-compose`. You can wipe all the state of the application and all the services (including the postgres database) attached to it by running `docker-compose down --volumes --remove-orphans`. In particular, you may need to do this if you are making breaking changes to the database structure, or if you have corrupted something somehow. However, do be careful, because this will delete **all** the state saved in the application and database - and there is no way to retrieve it. So make sure you back up anything you want to save before running the command.


# Viewing the Application
## if you chose the local route, then you are good to go on:
  http://localhost:3000
  $ `rspec` (to run the test suite), or, `bundle exec rspec` (if the `rspec` does not work)


# Other Tips to Get Started

## Logging In
A username and password to log in and test the app are in `seeds.rb` (which then references your environment variables)

## Testing
* Running `bin/test` will run ruby tests (rspec) and then the js tests (mocha) if all the rspec tests pass
* To run front end tests and back end tests individually:
    * Vue.js front end tests: `yarn test` or `yarn test -w` (mocha and chai are included in the `package.json` )
    * Rails front end and back end tests: `bin/rspec` (rspec is included in the Gemfile)

When writing rspec tests within the spec/request directory, you can use `Warden::Test:Helpers`
which give you access to the ```login_as(user, :scope => :user)``` method, as well as the ```logout``` method.
You use `FactoryBot.create(:user)` before the `login_as` method and pass it in as the required resource variable.
BE SURE to include the line ```after { Warden.test_reset! } ``` after the `before do` block with the `login_as` method
within it. This allows for any unexpected state data of the user from hanging around and causing errors.

## Data
* Running `db:seed` will create basic types, etc, for test and production environments.
* We also added some fake data seed files for you to use that are callable via rake tasks (these are in `lib/tasks/db.rake`)
  - To start fresh with prod seeds only (e.g. user account, organization, basic contact methods, languages, etc): `rake db:rebuild_and_seed`
  - To add some dev seeds: `rake db:import_all_seeds`
  - All options:
    - `rake db:rebuild_and_seed` (drop, create, migrate, seed, stats_check)
    - `rake db:rebuild_and_seed_dev` (drop, create, migrate, seed, import_all_seeds, stats_check)
    - `rake db:stats_check` (outputs record totals)
    - `rake db:truncate_tables` (runs truncate on all tables)
    - `rake db:recreate_all_seeds` (delete_all_data, seed, import_all_seeds, stats_check)
    - `rake db:import_all_seeds` (import_dev_seeds, import_submission_response_seeds, import_user_seeds, import_custom_form_question_seeds, stats_check)
    - `rake db:import_dev_seeds` (runs the db/seeds/dev_seeds.rb file)
    - `rake db:import_submission_response_seeds` (runs the db/scripts/submission_response_seeds.rb file -- you could edit this to pull from the db/seeds/gitignored_csvs path if you have a file you want to import)
    - `rake db:import_user_seeds` (runs the db/scripts/user_seeds.rb file)
    - `rake db:import_custom_form_question_seeds` (runs the db/scripts/custom_form_question_seeds.rb file)

* To load your data
  - Use the templates provided in `db/seeds/public_template_csvs` to get your data formatted
  - Save copies in `db/seeds/gitignored_csvs` (or keep them in your local dir)
  - Edit `db/scripts/submission_response_seeds_gitignored_csvs` script to call your files
  - Run `rails runner -e development db/scripts/submission_response_seeds_gitignored_csvs.rb`
    - If you get this error:
      - ```Running via Spring preloader in process 13613
         Please specify a valid ruby command or the path of a script to run.
         Run 'rails runner -h' for help.```
      - Run `spring stop` and try again

# Deploying the app
## If you decide to deploy to Heroku:
* [Heroku Command Line Interface](https://devcenter.heroku.com/categories/command-line)
* If you have HTTPS enabled (requires a paid dyno), be sure to enable `config.force_ssl = true` on line 47 of `config/environments/production.rb`

## If you decide to use Docker:

_Note_: These instructions assume you are working with shell access to a system with Docker and docker-compose available (such as a Digital Ocean Docker image).

_Note_: These instructions assume you already have a domain name registered and pointed it at the
IP address of your server.

1. You'll need to get the code on the server. The recommended way to do this is with a [GitHub Deploy Key](https://developer.github.com/v3/guides/managing-deploy-keys/). Deploy Keys are just SSH keys that are tied to a project, instead of being tied to a user, which means that they can persist independently of the project's membership. You can use [GitHub's guide on generating SSH keys to generate your deploy key](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
2. After you've generated your deploy key and added it to your project, clone the project.
3. Create a Caddyfile. It can live anywhere (Mutual Aid Tompkins has ours at `~/.config/Caddyfile`), and it should look like this, replacing `your.domain.name` with your organization's desired domain name:

   ```
   your.domain.name {
     header {
       Strict-Transport-Security "max-age=31536000; includeSubdomains; preload"
     }

     root * /config/public

     # Serve static files (like assets and packs) with the file_server
     @static_files {
       file
     }
     file_server @static_files

     # Anything that's not a static file, proxy to puma/rails
     @backend {
       not file
     }
     reverse_proxy @backend http://app:3000
   }
   ```

4. Navigate to the `docker/production` directory within your clone of the repo. You should see a file named `docker-compose.yml`.
5. Run
   ```bash
   docker-compose run app '/usr/local/bin/rake' secret \
    | echo "SECRET_KEY_BASE=$(tail -1 -)" > .env
   ```
   This will generate a secret token and add it to a file named `.env`, which will be available when
   `docker-compose` starts.
6. Generate (using a password manager) a password for the Postgres database, and append it to the `.env` file. Your `.env` file should look something like:
   ```bash
   SECRET_KEY_BASE=<A fairly long string of numbers>
   POSTGRES_PASSWORD=<your postgres password>
   ```
7. Start the server, database, and reverse proxy by running `docker-compose --build -d`
8. Initialize the database with
   ```bash
   docker-compose run \
     -e SYSTEM_EMAIL="theemailyouwanttouse@example.com" \
     -e SYSTEM_PASSWORD="ThePasswordYouWantToUse" \
     app rails db:prepare db:seed
   ```
   This will setup the database and create a default admin user with the email and password as  specified by the `SYSTEM_EMAIL` and `SYSTEM_PASSWORD` environment variables you passed to  `docker-compose` with the `-e` option. If you don't want to create the default user, you can just  run `docker-compose run app db:prepare` and create the account using the sign up option on the  website. **Only run this command the first time you set up your instance**

You should be good to go! Visit your domain name to get started.

## Make sure to run `rake db:seed`

# Diagrams!
We've got a rudimentary ERD diagram, and some workflow diagrams all in one `db_diagram_yEd.graphml` file in the db dir
(yEd is desktop software for creating diagrams)

# Customization
## How to change colors (TBD)...
