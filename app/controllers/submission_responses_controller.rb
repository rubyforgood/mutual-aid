class SubmissionResponsesController < ApplicationController
  before_action :set_submission_response, only: [:show, :edit, :update, :destroy]

  # GET /submission_responses
  # GET /submission_responses.json
  def index
    @submission_responses = SubmissionResponse.all
  end

  # GET /submission_responses/1
  # GET /submission_responses/1.json
  def show
  end

  # GET /submission_responses/new
  def new
    @submission_response = SubmissionResponse.new
  end

  # GET /submission_responses/1/edit
  def edit
  end

  # POST /submission_responses
  # POST /submission_responses.json
  def create
    @submission_response = SubmissionResponse.new(submission_response_params)

    respond_to do |format|
      if @submission_response.save
        format.html { redirect_to @submission_response, notice: 'Submission response was successfully created.' }
        format.json { render :show, status: :created, location: @submission_response }
      else
        format.html { render :new }
        format.json { render json: @submission_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submission_responses/1
  # PATCH/PUT /submission_responses/1.json
  def update
    respond_to do |format|
      if @submission_response.update(submission_response_params)
        format.html { redirect_to @submission_response, notice: 'Submission response was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission_response }
      else
        format.html { render :edit }
        format.json { render json: @submission_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submission_responses/1
  # DELETE /submission_responses/1.json
  def destroy
    @submission_response.destroy
    respond_to do |format|
      format.html { redirect_to submission_responses_url, notice: 'Submission response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission_response
      @submission_response = SubmissionResponse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def submission_response_params
      params.require(:submission_response).permit(:submission_id, :custom_form_question_id, :boolean_response, :date_response, :datetime_response, :integer_response, :text_response, :string_response, :array_response)
    end
end
