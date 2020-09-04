[![CircleCI](https://circleci.com/gh/rubyforgood/mutual-aid/tree/main.svg?style=svg)](https://circleci.com/gh/rubyforgood/mutual-aid/tree/main)

### Welcome, and thanks for coming by!

# Ruby for Good 2020 invite:
Mutual Aid is when people get together to build community by volunarily sharing resources with each other. Mutual Aid groups are more concerned about local resiliency than global campaigns, and prefer solidarity before charity. Mutual aid groups have existed around the world for over 200 years. Mutual aid groups generally prioritize the needs of minorities and other underserved communities.

Our [project pitch deck](https://docs.google.com/presentation/d/1iUakTWYsj1tMAyOUO-1gp4oxNJzwGTFsZnkkDJk8Ax8/edit?usp=drive_web&ouid=109561030287749477812) for the event

About mutual aid, [a list](https://bigdoorbrigade.wordpress.com/2017/01/31/what-do-we-mean-by-mutual-aid/)
About mutual aid, [a video that covers a lot of ground](https://www.deanspade.net/2019/07/10/animated-video-about-mutual-aid/)
Many people working in mutual aid were overwhelmed by requests early this year due to the COVID pandemic. Some of these groups were relying on dispatchers to match up people who could help each other. These dispatchers were in turn relying on spreadsheets, and the spreadsheets grew to be unmanageable. We've created an app to help. Seven mutual aid groups in cities across the country are now using this app.

Our current status is that dispatcher capacity is waning as local governments restart schools and lift pandemic bans. We have some bugfixes and small tickets to address this problem. We're also looking for people who are willing to spend a few days digging in to our new peer-to-peer communication path that will ease how much we rely on dispatchers.

We would love contributions from newbies, experienced devs, UX/UI designers and PM folks. We'll have tickets for people to work on as individuals, and we'll have pairing and groupings available too. Hope to see you in #mutualaid and/or the social events being held!
Visit our [CONTRIBUTING.md](CONTRIBUTING.md) file for more info.

We have two projects - [Roadmap](https://github.com/rubyforgood/mutual-aid/projects) and [Story map](https://github.com/rubyforgood/mutual-aid/projects/2). These cover the same list of github issues, but the [Roadmap](https://github.com/rubyforgood/mutual-aid/projects) focuses on prioritization of issues, whereas the [Story map](https://github.com/rubyforgood/mutual-aid/projects/2) is a higher level overview and a good reference point of user flows (tho it was last updated spring 2020).
All issues (and maps) are being groomed throughout these two weeks (9/1 - 9/13), so, please keep checking back for updates. If you have any questions and/or are having a hard time finding where or how to jump in to the project, reach out to us in the #mutualaid channel in the Ruby for Good Slack!


[GitHub](https://github.com/rubyforgood/mutual-aid)

Slack channel: #mutualaid
Slack contacts: @maebeale, @lasitha, @Howard, @svetlana, PM support: @Ginger A, Stakeholder reps: @Robin, @Siv Jones


# Who we are:
We are devs committed to making mutual aid manageable and longstanding, so as to build, support, and strengthen resilient communities.

We aim to support people in working smarter, not harder.

This is not intended to be strictly a "product" -- we will be in partnership with specific mutual aid groups to solicit feedback and support their operations, with a nod to all mutual aid groups and administrative best practices.

The idea is that each group -- or cluster of groups -- would own their database and "instance" of this software, rather than there becoming one large/shared database (as is the case with products). This is to protect privacy, and to prioritize locality.

Ideally mutual aid networks will have their own tech teams, but we will provide initial support as capacity permits.

Feel free to [browse some of our earliest notes](ORIENTATION.md)


# Background
Mutual aid is not new. If it is new to you, please check out the history of mutual aid in your neighborhood or region, as likely you will find mentors and partners ready to accept your help. There are most likely leaders of color in your area. Please see if there are ways to support them before creating your own new network.

Mutual aid groups are community groups that member-led, member-organized, and open to all to participate in.
Mutual aid participants work together to figure out strategies and resources to meet each others' needs, such as food, housing, medical care, and disaster relief.
Typically one member requests something and they are matched with a member who wishes to contribute that very thing.
In addition to the background links in the Ruby for Good section, here's a [good definition of a mutual aid network](https://www.idealist.org/en/days/what-is-a-mutual-aid-network).
There is plenty of research to be done, and national and regional networks to connect in to.
Please, get involved! All of our communities could benefit from more resiliency and connection.


If you have any question of us source code maintainers, please feel free to reach out in the #mutualaid channel in Ruby for Good Slack (we're affiliated) or connect with us through GitHub.

# Contributing
Visit our [CONTRIBUTING.md](CONTRIBUTING.md) file for more information on making your contribution. We look forward to it!

We have two projects - Roadmap and Feature map (https://github.com/rubyforgood/mutual-aid/projects). These cover the same list of github issues, but the Roadmap focuses on prioritization of issues, whereas the Feature Map is a higher level overview and a good reference point of user flows.
All issues (and maps) are being groomed throughout these two weeks (9/1/2020 - 9/13/2020), so, please keep checking back for updates. If you have any questions and/or are having a hard time finding where or how to jump in to the project, reach out to us in the #mutualaid channel in the Ruby for Good Slack!

# Setting up development
Visit our [SETUP.md](SETUP.md) file for more information on making your contribution. We look forward to it!

# Viewing the Application
## We've got a demo instance!
* [http://mutual-aid-demo.herokuapp.com/](http://mutual-aid-demo.herokuapp.com/) 
* credentials: mutualaidtesting@example.com, testing123

## And a test instance you can use to test your changes before deploying to your production environment
* [http://mutual-aid-test.herokuapp.com/](http://mutual-aid-test.herokuapp.com/) 
* credentials: mutualaidtesting@example.com, testing123

## if you chose the local [SETUP](SETUP.md) route (and are running the app locally via `rails s`), then you are good to go on:
  [http://localhost:3000](http://localhost:3000)
  $ `rspec` (to run the test suite), or, `bin/rspec` (if the `rspec` does not work)

## Glossary!
* We wrote up a [Glossary of terms](http://mutual-aid-demo.herokuapp.com/admin/glossary)  that's available in the demo instance once you're logged in.
You can also check out the [view code](blob/main/app/views/admin/glossary.html.erb).



# Deploying the app

Visit our [DEPLOYMENT.md](DEPLOYMENT.md) file for more information on deploying the app.

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

## Data (seeds and imports)
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

# Diagrams!
We've got a rudimentary ERD diagram, and some workflow diagrams all in one `db_diagram_yEd.graphml` file in the db dir
(yEd is desktop software for creating diagrams)

# Customization
## How to change colors (TBD)...
