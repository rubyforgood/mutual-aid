# frozen_string_literal: true

class SoftwareFeedbacksController < ApplicationController
  before_action :set_software_feedback, only: %i[show edit update destroy]

  def index
    @software_feedbacks = SoftwareFeedback.all
  end

  def show; end

  def new
    @software_feedback = SoftwareFeedback.new
    set_form_dropdowns
  end

  def edit
    set_form_dropdowns
  end

  def create
    @software_feedback = SoftwareFeedback.new(software_feedback_params)

    if @software_feedback.save
      redirect_to software_feedbacks_path, notice: 'Software feedback was successfully created.'
    else
      set_form_dropdowns
      render :new
    end
  end

  def update
    if @software_feedback.update(software_feedback_params)
      redirect_to software_feedbacks_path, notice: 'Software feedback was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    @software_feedback.destroy
    redirect_to software_feedbacks_url, notice: 'Software feedback was successfully destroyed.'
  end

  private

    def set_software_feedback
      @software_feedback = SoftwareFeedback.find(params[:id])
    end

    def set_form_dropdowns
      @feedback_types = SoftwareFeedback::FEEDBACK_TYPES
      @module_name = SoftwareFeedback::MODULE_NAMES
      @urgencies = SoftwareFeedback::URGENCIES
    end

    def software_feedback_params
      params.require(:software_feedback).permit(:created_by_id, :feedback_type, :module_name, :page_url, :name, :urgency, :urgency_order, :notes, :completed, :completed_at)
    end
end
