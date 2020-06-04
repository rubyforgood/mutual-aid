# run from the command line with:  rails runner  -e development db/scripts/submission_response_seeds_gitignored_csvs.rb

require 'csv'

csv = "submission_responses.csv"
path = Rails.root.join('db', 'seeds', 'public_template_csvs', csv)
importer = Importers::SubmissionResponseImporter.new(User.first, csv)
importer.import(path)


# TODO remove explicit name here
requests_csv = 'Requests-Table 1.csv'
offers_csv = 'New offers-Table 1.csv'
old_offers_csv = 'Old offers-Table 1.csv'


csvs = [requests_csv, offers_csv, old_offers_csv]
# csvs.each do |csv| # TODO uncomment

  csv = requests_csv # TODO remove
  path = Rails.root.join('db', 'seeds', 'gitignored_csvs', csv)
  importer = Importers::SubmissionResponseImporter.new(User.first, csv)
  importer.import(path)
  puts "completed #{csv}"

# end # TODO uncomment


puts "completed gitignored submission_response csvs import"
