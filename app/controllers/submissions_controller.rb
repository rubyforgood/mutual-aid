class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  def index
    @submissions = Submission.order(created_at: :desc)
  end

  def show
  end

  def new
    @submission = Submission.new
    set_form_dropdowns
  end

  def edit
    set_form_dropdowns
  end

  def create
    @submission = Submission.new(submission_params)

    outcome = SaveSubmission.run params[:submission] # saving a Submission based on Listing properties bc
    # creating Listing first rn, but prob need to reverse that since listing belongs_to :submission now
    if outcome.valid?
      redirect_to contribution_thank_you_path, notice: 'Submission was successfully created.'
    else
      set_form_dropdowns
      render :new
    end
  end

  def update
    if @submission.update(submission_params)
      redirect_to submissions_path, notice: 'Submission was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    @submission.destroy
    redirect_to submissions_url, notice: 'Submission was successfully destroyed.'
  end

  private
    def set_submission
      @submission = Submission.find(params[:id])
    end

    def set_form_dropdowns
      @form_names = ["ask_form", "offer_form", "community_resources_form", "announcements_form"]
    end

    def submission_params
      params.require(:submission).permit(:person_id, :service_area_id, :body, :form_name, :privacy_level_requested)
    end
end
