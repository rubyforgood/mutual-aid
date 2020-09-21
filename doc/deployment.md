# Deploying the app

<sub>↩ Back to [README](/README.md)</sub>

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


<sub>↩ Back to [README](/README.md)</sub>
