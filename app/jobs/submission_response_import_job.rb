class SubmissionResponseImportJob < ApplicationJob
  queue_as :default

  # FIXME: this accepts the whole file contents as an in-memory string, which won't scale well
  def perform user_id:, file_name:, file_contents:
    user = User.find user_id
    importer = Importers::SubmissionResponseImporter.new user, file_name
    importer.import_string file_contents
  end
end
