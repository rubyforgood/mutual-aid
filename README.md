# Who we are:

We are devs committed to making mutual aid manageable and longstanding, so as to build, support, and strengthen resilient communities.

We aim to support people in working smarter, not harder.

This is not intended to be strictly a "product" -- we will be in partnership with specific mutual aid groups to solicit feedback and support their operations, with a nod to all mutual aid groups and administrative best practices.

The idea is that each group -- or cluster of groups -- would own their database and "instance" of this software, rather than there becoming one large/shared database (as is the case with products).

Ideally mutual aid networks will have their own tech teams, but we will provide initial support as capacity permits.


# Contributing

Visit our [CONTRIBUTING.md](https://github.com/maebeale/mutual-aid-app/blob/develop/CONTRIBUTING.md) file for more information on making your contribution. We look forward to it!


# Background
Mutual aid is not new. If it is new to you, please check out the history of mutual aid in your neighborhood or region, as likely you will find mentors and partners ready to accept your help. There are most likely leaders of color in your area. Please see if there are ways to support them before creating your own new network.

There is plenty of research to be done, and national and regional networks to connect in to. Here's one offering of a [mutual aid course](https://app.organizetogether.network/courses/2128977/content).

If you have any questions, please feel free to reach out in the #mutualaid channel in Ruby for Good Slack or on Github.

# Setting Up Development

This is a Ruby on Rails 6.0 application with Vue + Webpack included.

To get started developing on your machine, you'll need the following tools installed:

* ruby 2.7
* node 10+
* yarn 1.16+
* bundler 2+
* vue (v?)
* bulma (v?)

Some choices for how to run services in your development environment:
* [Heroku Command Line Interface](https://devcenter.heroku.com/categories/command-line)
* [Docker Desktop](https://www.docker.com/products/docker-desktop) to use the docker-compose steps or you will need to install these services individually on your development host:
    * Redis 4+
    * PostgreSQL 9.5+
    * Mailcatcher 0.7.1

## Setting up Ruby

The easiest way to manage different installations of Ruby is with [rbenv](https://github.com/rbenv/rbenv). After following the installation instructions on the rbenv repo and restarting your terminal, you'll be able to run `rbenv install` in the root directory of the repository. rbenv will handle installing Ruby and switching to it for you when you enter the repo (so no need to worry about your other Ruby installs!) After that, run `gem install bundler` and you'll be all set to run `bundle install`.

If you run into a problem where your bundle install says you're on an older version of bundler than what's in the lockfile, run `gem update --system` to update RubyGems, then `gem install bundler:1.17.3`

Depending on your system, you might have trouble building the `pg` gem, probably due to a missing `libpq-fe.h`. To get the necessary libraries installed:
* Debian/Ubuntu: `sudo apt-get install libpq-dev`
* On Enterprise Linux (CentOS/RHEL/Fedora/Amazon Linux/Sci Linux): `yum install postgresql-devel`
* For Mac (Homebrew): `brew install postgresql`

## Setting up Node

The easiest way to manage different installations with node.js is with [nvm](https://github.com/nvm-sh/nvm). After following the installation instructions, type `nvm install` to install and run the right version of node.js.

You'll also need Yarn, a package manager for node.js. To install that:
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
* For Mac (Homebrew): `brew install yarn`

## Setting up Heroku

The Rails and webpack processes are launched with Heroku. You can install Heroku Local using [these instructions](https://devcenter.heroku.com/articles/heroku-cli).

## Running the App!

First, set up Local Services via [Docker](#development-with-docker) or individually installed services. 

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

You only need this if you're interested in working on emails in the development environment.

### Run the App Locally

Then, to run the app locally,

```
$ bundle install
$ yarn install
$ rake dev:setup
$ heroku local -f Procfile.dev
```

if you run into the following error:
```bash: heroku: command not found``` visit https://devcenter.heroku.com/articles/heroku-cli for instructions to install Heroku.

## Development with Docker

The application includes a pre-configured [docker-compose](https://docs.docker.com/compose/) environment. This environment includes two containers, which together deploy the application and a postgres database for it to connect to.

To get started using the application with docker,
1. Install [Docker](https://www.docker.com/get-started)
2. Install [docker-compose](https://docs.docker.com/compose/install/)
3. Clone the repository, and open the repository folder in your favorite command line or terminal application.
4. From within the repository, navigate to the `/docker/development` folder. If you are in the right folder, you will see a file named `docker-compose.yml`.
5. Run `docker-compose run app '/usr/local/bin/rake' secret | tail -n1 | echo "SECRET_KEY_BASE=$(cat -)" >> .env`, if you have not done so already.
6. Now you should be able to run `docker-compose up -d`. This will start the application in daemon mode, which means that the server will keep running in the background. If you navigate to  `localhost:3000` in your browser, you will see an error. This is normal, and it means that you still need to setup the database.
7. To setup the database, you can run `docker-compose run -e SYSTEM_EMAIL="theemailyouwanttouse@example.com" -e SYSTEM_PASSWORD="ThePasswordYouWantToUse" app rails db:prepare db:seed`. This will setup the database and create a default admin user with the email and password as specified by the `SYSTEM_EMAIL` and `SYSTEM_PASSWORD` environment variables you passed to `docker-compose` with the `-e` option. If you don't want to create the default user, you can just run `docker-compose run app db:prepare` and create the account using the sign up option on the website.
8. You should now be able to reload `localhost:3000` in your browser. If everything went well, the website should appear and be functional. You can sign in using the email and password you set in the previous step. This docker compose also setups an a `mailcatcher` server, which you can access at `localhost:1080`. All emails will be delivered to mailcatcher, which should allow you to setup user accounts.

**NOTE** Do not use this method in production! This is for **testing & development only* the configuration used with in this docker-compose file is highly insecure and should never be exposed to the public internet.

Note that if you are developing this application, running `docker-compose up` a second time after you have made changes may not update the version of the application deployed by `docker-compose`. To ensure that `docker-compose` builds a new image that includes you changes, run `docker-compose up --build` instead. 

Also, if you would like docker-compose to run in daemon mode (which means that it will exit once the images have been set up and the application starts running) you may use `docker-compose up -d`. This will not show you any logging output from the application, however, and you will not be able to exit the application directly. To view logs when docker-compose is running in daemon mode, use `docker-compose logs`. To stop the application and all its services, run `docker-compose down`.

**NOTE** the application will save its state between successively invocations of `docker-compose up --build`. This means that if you make changes to the database - for example by adding content or users - then those changes will persist the next time you start the application with `docker-compose`. You can wipe all the state of the application and all the services (including the postgres database) attached to it by running `docker-compose down --volumes --remove-orphans`. In particular, you may need to do this if you are making breaking changes to the database structure, or if you have corrupted something somehow. However, do be careful, because this will delete **all** the state saved in the application and database - and there is no way to retrieve it. So make sure you back up anything you want to save before running the command.


# Viewing the Application
## if you chose the local route, then you are good to go on:
  http://localhost:3000
  $ rspec (to run the test suite) or bundle exec rspec (if the first does not work)
  
# Other Tips to Get Started

## Loggin In
A username and password to log in and test the app are in `seeds.rb`

## Testing
When writing tests for rspec tests within the spec/request directory, you can use Warden::Test:Helpers
which give you access to the ```login_as(user, :scope => :user)``` method, as well as the ```logout``` method.
You use FactoryBot.create(:user) before the login_as method and pass it in as the required resource variable.
BE SURE to include the line ```after { Warden.test_reset! } ``` after the before do block with the login_as method
within it. This allows for any unexpected state data of the user from hanging around and causing errors.

Additional testing for front_end specs should make use of Capybara ```sign_in/sign_out``` Capybara methods.

## App Startup Troubleshooting
If you Receive an error when trying to run

```
$ heroku local -f Procfile.dev
```

that looks like this ...

```
joe-shmo:~/projects/mutual-aid-app(develop)$ heroku local -f Procfile.dev
 ›   Warning: heroku update available from 7.26.2 to 7.33.3.
[OKAY] Loaded ENV .env File as KEY=VALUE Format
12:02:46 PM web.1    |  => Booting Puma
12:02:46 PM web.1    |  => Rails 5.2.3 application starting in development
12:02:46 PM web.1    |  => Run `rails server -h` for more startup options
12:02:46 PM webpack.1 |  events.js:167
12:02:46 PM webpack.1 |        throw er; // Unhandled 'error' event
12:02:46 PM webpack.1 |        ^
12:02:46 PM webpack.1 |  Error: listen EADDRINUSE: address already in use 127.0.0.1:3035
12:02:46 PM webpack.1 |      at Server.setupListenHandle [as _listen2] (net.js:1290:14)
12:02:46 PM webpack.1 |      at listenInCluster (net.js:1338:12)
12:02:46 PM webpack.1 |      at GetAddrInfoReqWrap.doListen [as callback] (net.js:1471:7)
12:02:46 PM webpack.1 |      at GetAddrInfoReqWrap.onlookup [as oncomplete] (dns.js:62:10)
12:02:46 PM webpack.1 |  Emitted 'error' event at:
12:02:46 PM webpack.1 |      at emitErrorNT (net.js:1317:8)
12:02:46 PM webpack.1 |      at process._tickCallback (internal/process/next_tick.js:63:19)
[DONE] Killing all processes with signal  SIGINT
```

Run -
``` $ ps aux | grep node ```
and then use the following command on any PIDs that have mutual aid in the path, or mentions node/procfiles

```
kill -9 <PID #>
```
Then Re-run -

```
$ heroku local -f Procfile.dev
```
