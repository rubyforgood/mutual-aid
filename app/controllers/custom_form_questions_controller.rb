# frozen_string_literal: true

class CustomFormQuestionsController < AdminController
  before_action :set_custom_form_question, only: %i[show edit update destroy]

  def index
    @custom_form_questions = CustomFormQuestion.all
  end

  def show; end

  def new
    @custom_form_question = CustomFormQuestion.new
    @input_types_array = CustomFormQuestion::INPUT_TYPES_AND_STORAGE.keys
  end

  def edit
    @input_types_array = CustomFormQuestion::INPUT_TYPES_AND_STORAGE.keys
  end

  def create
    @custom_form_question = CustomFormQuestion.new(custom_form_question_params)

    if @custom_form_question.save
      redirect_to custom_form_questions_path, notice: 'Custom form question was successfully created.'
    else
      render :new
    end
  end

  def update
    if @custom_form_question.update(custom_form_question_params)
      redirect_to custom_form_questions_path, notice: 'Custom form question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @custom_form_question.destroy
    redirect_to custom_form_questions_url, notice: 'Custom form question was successfully destroyed.'
  end

  private

    def set_custom_form_question
      @custom_form_question = CustomFormQuestion.find(params[:id])
    end

    def custom_form_question_params
      params.require(:custom_form_question).permit(
          :input_type,
          :is_required,
          :form_type,
          :hint_text,
          :name,
          :display_order,
          :form_hook,
          option_list: [],
          )
    end
end
