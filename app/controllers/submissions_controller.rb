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

    if @submission.save && email_confirmation_and_log(@submission, current_user)
      redirect_to submissions_path, notice: 'Submission successfully created.'
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

  def email_confirmation_and_log(submission, current_user)
    Rails.logger.info "----------------SEND EMAIL CONFIRMATION"
    # send the email
    autoemail = SubmissionMailer.new_submission_confirmation_email(submission, @system_setting)
    delivery_status = deliver_now_with_error_handling(autoemail, "new_submission_confirmation_email")

    # store email that was sent
    CommunicationLog.log_submission_email(autoemail, delivery_status, submission, CommunicationLog::AUTO_DELIVERY_CHANNEL, current_user)
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
