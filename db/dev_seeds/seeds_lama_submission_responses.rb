require 'csv'

requests_csv = 'sanitized info import - Requests.csv'
offers_csv = 'sanitized info import - New offers.csv'
old_offers_csv = 'sanitized info import - Old offers.csv'

csvs = [requests_csv, offers_csv, old_offers_csv]
csvs.each do |csv|

  csv = 'sanitized info import - Requests.csv' # TODO remove
  path = Rails.root.join('db', 'dev_seeds', csv)
  importer = Importers::SubmissionResponseImporter.new(User.first, csv)
  importer.import(path)
  puts "completed #{csv}"
end
puts "completed seeds_lama_submission_responses.csv"
