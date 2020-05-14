class CustomFormQuestionsController < ApplicationController
  before_action :set_custom_form_question, only: [:show, :edit, :update, :destroy]

  def index
    @custom_form_questions = CustomFormQuestion.all
  end

  def show
  end

  def new
    @custom_form_question = CustomFormQuestion.new
    @input_types_array = CustomFormQuestion::INPUT_TYPES_AND_STORAGE.keys
  end

  def edit
    @input_types_array = CustomFormQuestion::INPUT_TYPES_AND_STORAGE.keys
  end

  def create
    @custom_form_question = CustomFormQuestion.new(custom_form_question_params)

    respond_to do |format|
      if @custom_form_question.save
        format.html { redirect_to custom_form_questions_path, notice: 'Custom form question was successfully created.' }
        format.json { render :show, status: :created, location: @custom_form_question }
      else
        format.html { render :new }
        format.json { render json: @custom_form_question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @custom_form_question.update(custom_form_question_params)
        format.html { redirect_to custom_form_questions_path, notice: 'Custom form question was successfully updated.' }
        format.json { render :show, status: :ok, location: @custom_form_question }
      else
        format.html { render :edit }
        format.json { render json: @custom_form_question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @custom_form_question.destroy
    respond_to do |format|
      format.html { redirect_to custom_form_questions_url, notice: 'Custom form question was successfully destroyed.' }
      format.json { head :no_content }
    end
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
