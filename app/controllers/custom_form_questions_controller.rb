class CustomFormQuestionsController < ApplicationController
  before_action :set_custom_form_question, only: [:show, :edit, :update, :destroy]

  # GET /custom_form_questions
  # GET /custom_form_questions.json
  def index
    @custom_form_questions = CustomFormQuestion.all
  end

  # GET /custom_form_questions/1
  # GET /custom_form_questions/1.json
  def show
  end

  # GET /custom_form_questions/new
  def new
    @custom_form_question = CustomFormQuestion.new
    @input_types_array = CustomFormQuestion::INPUT_TYPES_AND_STORAGE.keys
  end

  # GET /custom_form_questions/1/edit
  def edit
    @input_types_array = CustomFormQuestion::INPUT_TYPES_AND_STORAGE.keys
  end

  # POST /custom_form_questions
  # POST /custom_form_questions.json
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

  # PATCH/PUT /custom_form_questions/1
  # PATCH/PUT /custom_form_questions/1.json
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

  # DELETE /custom_form_questions/1
  # DELETE /custom_form_questions/1.json
  def destroy
    @custom_form_question.destroy
    respond_to do |format|
      format.html { redirect_to custom_form_questions_url, notice: 'Custom form question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_custom_form_question
      @custom_form_question = CustomFormQuestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def custom_form_question_params
      params.require(:custom_form_question).permit(
          :input_type,
          :is_required,
          :form_type,
          :hint_text,
          :name,
          :position,
          option_list: [],
          )
    end
end
