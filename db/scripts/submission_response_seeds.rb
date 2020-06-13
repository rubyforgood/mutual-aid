# run from the command line with:  rails runner  -e development db/scripts/submission_response_seeds.rb

require 'csv'

csv = "submission_responses.csv"
path = Rails.root.join('db', 'seeds', 'public_template_csvs', csv)
importer = Importers::SubmissionResponseImporter.new(User.first, csv)
importer.import(path)

puts "completed submission_responses.csv"
