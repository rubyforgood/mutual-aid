require 'csv'

csv = 'custom_form_questions_LAMA.csv'
path = Rails.root.join('db', 'dev_seeds', csv)
importer = Importers::CustomFormQuestionImporter.new(User.first)
importer.import(path)
puts "completed seeds_lama.csv"
