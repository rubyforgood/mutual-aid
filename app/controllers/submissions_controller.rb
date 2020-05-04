class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  def index
    @submissions = Submission.order(created_at: :desc)
  end

  def show
  end

  def new
    @submission = Submission.new
  end

  def edit
  end

  def create
    @submission = Submission.new(submission_params)

    respond_to do |format|
      if @submission.save
        Rails.logger.info "----------------SEND EMAIL CONFIRMATION"
        # send the email
        autoemail = SubmissionMailer.new_submission_confirmation_email(@submission)
        delivery_status = deliver_now_with_error_handling(autoemail, "new_submission_confirmation_email")

        # store email that was sent
        CommunicationLog.log_submission_email(autoemail, delivery_status, @submission, CommunicationLog::AUTO_DELIVERY_CHANNEL, current_user)

        format.html { redirect_to submissions_path,
                                  notice: 'Submission successfully created.' }
        format.json { render :new,
                             status: :created,
                             location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to submissions_path, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_submission
      @submission = Submission.find(params[:id])
    end

    def submission_params
      params.require(:submission).permit(:person_id, :service_area_id, :body, :form_name, :privacy_level_requested)
    end
end
