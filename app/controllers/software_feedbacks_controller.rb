class SoftwareFeedbacksController < ApplicationController
  before_action :set_software_feedback, only: [:show, :edit, :update, :destroy]

  # GET /software_feedbacks
  # GET /software_feedbacks.json
  def index
    @software_feedbacks = SoftwareFeedback.all
  end

  # GET /software_feedbacks/1
  # GET /software_feedbacks/1.json
  def show
  end

  # GET /software_feedbacks/new
  def new
    @software_feedback = SoftwareFeedback.new
  end

  # GET /software_feedbacks/1/edit
  def edit
  end

  # POST /software_feedbacks
  # POST /software_feedbacks.json
  def create
    @software_feedback = SoftwareFeedback.new(software_feedback_params)

    respond_to do |format|
      if @software_feedback.save
        format.html { redirect_to @software_feedback, notice: 'Software feedback was successfully created.' }
        format.json { render :show, status: :created, location: @software_feedback }
      else
        format.html { render :new }
        format.json { render json: @software_feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /software_feedbacks/1
  # PATCH/PUT /software_feedbacks/1.json
  def update
    respond_to do |format|
      if @software_feedback.update(software_feedback_params)
        format.html { redirect_to @software_feedback, notice: 'Software feedback was successfully updated.' }
        format.json { render :show, status: :ok, location: @software_feedback }
      else
        format.html { render :edit }
        format.json { render json: @software_feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /software_feedbacks/1
  # DELETE /software_feedbacks/1.json
  def destroy
    @software_feedback.destroy
    respond_to do |format|
      format.html { redirect_to software_feedbacks_url, notice: 'Software feedback was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software_feedback
      @software_feedback = SoftwareFeedback.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def software_feedback_params
      params.require(:software_feedback).permit(:created_by_id, :feedback_type, :module_name, :page_url, :name, :urgency, :urgency_order, :notes, :completed, :completed_at)
    end
end
