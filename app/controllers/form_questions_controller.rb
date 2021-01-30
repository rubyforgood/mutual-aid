# frozen_string_literal: true

class FormQuestionsController < AdminController
  before_action :set_form_question, only: %i[show edit update destroy]

  def index
    @form_questions = FormQuestion.all
  end

  def show; end

  def new
    @form_question = FormQuestion.new
    set_form_dropdowns
  end

  def edit
    set_form_dropdowns
  end

  def create
    @form_question = FormQuestion.new(form_question_params)

    if @form_question.save
      redirect_to form_questions_path, notice: 'FormQuestion was successfully created.'
    else
      set_form_dropdowns
      render :new
    end
  end

  def update
    if @form_question.update(form_question_params)
      redirect_to form_questions_path, notice: 'FormQuestion was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    @form_question.destroy
    respond_to do |form_questionat|
      form_questionat.html { redirect_to form_questions_url, notice: 'FormQuestion was successfully destroyed.' }
      form_questionat.json { head :no_content }
    end
  end

  private

  def set_form_question
    @form_question = FormQuestion.find(params[:id])
  end

  def set_form_dropdowns
    @custom_form_question_questions = CustomFormQuestion.all
    @form_questions = FormQuestion.all
  end

  def form_question_params
    params.require(:form_question).permit(
        :form_id,
        :custom_form_question_id,
    )
  end
end
