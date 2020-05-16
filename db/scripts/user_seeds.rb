require 'csv'

csv = 'users.csv'
path = Rails.root.join('db', 'seeds', 'public_template_csvs', csv)  # TODO change to gitignored_csvs
importer = Importers::UserImporter.new(User.first)
importer.import(path)

puts "completed user seeds"
