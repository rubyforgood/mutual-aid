class AsksController < PublicController
  layout "without_navbar", only: [:new, :create]

  def index
    redirect_to contributions_path
  end

  def new
    serialize(Submission.new)
  end

  def create
    submission = SubmissionForm.build submission_params
    if submission.save
      redirect_to contribution_thank_you_path, notice: 'Ask was successfully created.'
    else
      serialize(submission)
      render :new
    end
  end

  private
    def submission_params
      params[:submission].tap do |p|
        p[:form_name] = 'Ask_form'
        p[:listing_attributes][:type] = 'Ask'
      end
    end

    def serialize(submission)
      @json = {
        submission: SubmissionBlueprint.render_as_hash(submission),
        configuration: ConfigurationBlueprint.render_as_hash(nil),
      }.to_json
    end
end
