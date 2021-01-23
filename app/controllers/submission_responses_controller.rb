# frozen_string_literal: true

class SubmissionResponsesController < AdminController
  before_action :set_submission_response, only: %i[show edit update destroy]

  def index
    @submission_responses = SubmissionResponse.all
  end

  def show; end

  def new
    @submission_response = SubmissionResponse.new
  end

  def edit; end

  def create
    @submission_response = SubmissionResponse.new(submission_response_params)

    if @submission_response.save
      redirect_to @submission_response, notice: 'Submission response was successfully created.'
    else
      render :new
    end
  end

  def update
    if @submission_response.update(submission_response_params)
      redirect_to @submission_response, notice: 'Submission response was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @submission_response.destroy
    redirect_to submission_responses_url, notice: 'Submission response was successfully destroyed.'
  end

  private

    def set_submission_response
      @submission_response = SubmissionResponse.find(params[:id])
    end

    def submission_response_params
      params.require(:submission_response).permit(
        :array_response,
        :boolean_response,
        :custom_form_question_id,
        :date_response,
        :datetime_response,
        :integer_response,
        :string_response,
        :submission_id,
        :text_response,
      )
    end
end
