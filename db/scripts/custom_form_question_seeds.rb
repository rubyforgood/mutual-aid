# run from the command line with:  rails runner  -e development db/scripts/custom_form_question_seeds.rb

require 'csv'

csv = 'custom_form_questions.csv' # TODO remove this explicit name
path = Rails.root.join('db', 'seeds', 'public_template_csvs', csv)
# path = Rails.root.join('db', 'seeds', 'gitignored_csvs', csv) # use this line instead if using local/private csvs
importer = Importers::CustomFormQuestionImporter.new(User.first)
importer.import(path)
puts "completed seeds_custom_form_questions.csv"
