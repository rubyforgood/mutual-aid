require 'csv'

desc "Extra db functions: stats_check, reset db with seeds, import csv and seed data"

namespace :db do

  task :reset_seeded => ['db:drop',
                         'db:create',
                         'db:migrate',
                         'db:seed',
                         'db:stats_check']

  task :reset_seed_data => ['db:delete_all_data',
                            'db:seed',
                            'db:import_all_seeds',
                            'db:stats_check']

  task :setup_seeds => ['db_setup',
                        'db:import_all_seeds']

  task :import_all_seeds => ['db:import_dev_seeds',
                             'db:import_submission_response_seeds',
                             'db:import_user_seeds',
                             'db:import_custom_form_question_seeds',
                             'db:stats_check']

  task :stats_check => :environment do
    require "#{Rails.root}/db/scripts/tuple_counts.rb"
  end

  task :delete_all_data => :environment do
    require "#{Rails.root}/db/scripts/truncate_tables.rb"
  end

  task :import_dev_seeds => :environment do
    require "#{Rails.root}/db/seeds/dev_seeds.rb"
  end

  # use seed files stored in repo for easy templating of private files
  task :import_submission_response_seeds => :environment do
    require "#{Rails.root}/db/scripts/submission_response_seeds.rb"
  end

  task :import_user_seeds => :environment do
    require "#{Rails.root}/db/scripts/user_seeds.rb"
  end

  task :import_custom_form_question_seeds => :environment do
    require "#{Rails.root}/db/scripts/custom_form_question_seeds.rb"
  end

end


