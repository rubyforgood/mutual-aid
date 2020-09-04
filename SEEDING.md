## Seeding

Running `db:seed` will create basic types, etc, for test and production environments.

We also added some fake data seed files for you to use that are callable via rake tasks (these are in `lib/tasks/db.rake`)

* To start fresh with prod seeds only (e.g. user account, organization, basic contact methods, languages, etc): `rake db:rebuild_and_seed`
* To add some dev seeds: `rake db:import_all_seeds`
* All options:
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

## Importing

* Use the templates provided in `db/seeds/public_template_csvs` to get your data formatted
* Save copies in `db/seeds/gitignored_csvs` (or keep them in your local dir)
* Edit `db/scripts/submission_response_seeds_gitignored_csvs` script to call your files
* Run `rails runner -e development db/scripts/submission_response_seeds_gitignored_csvs.rb`
    - If you get this error:
      - ```Running via Spring preloader in process 13613
         Please specify a valid ruby command or the path of a script to run.
         Run 'rails runner -h' for help.```
      - Run `spring stop` and try again

[Back to README.md](README.md))
