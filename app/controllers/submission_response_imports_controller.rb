class SubmissionResponseImportsController < ApplicationController

  def new
  end

  def create
    uploaded_file = params[:submission_response_import]
    importer = Importers::SubmissionResponseImporter.new(current_user, uploaded_file.original_filename)
    importer.import(uploaded_file.path)
    redirect_to landing_page_admin_path
  end
end
