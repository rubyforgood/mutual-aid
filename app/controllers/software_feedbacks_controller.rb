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

    if @software_feedback.save
      redirect_to software_feedbacks_path, notice: 'Software feedback was successfully created.'
    else
      set_form_dropdowns
      render :new
    end
  end

  # PATCH/PUT /software_feedbacks/1
  # PATCH/PUT /software_feedbacks/1.json
  def update
    if @software_feedback.update(software_feedback_params)
      redirect_to software_feedbacks_path, notice: 'Software feedback was successfully updated.'
    else
      set_form_dropdowns
      render :edit
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
