class ExpenseTypesController < ApplicationController
  before_action :set_expense_type, only: [:show, :edit, :update, :destroy]

  # GET /expense_types
  # GET /expense_types.json
  def index
    @expense_types = ExpenseType.all
  end

  # GET /expense_types/1
  # GET /expense_types/1.json
  def show
  end

  # GET /expense_types/new
  def new
    @expense_type = ExpenseType.new
  end

  # GET /expense_types/1/edit
  def edit
  end

  # POST /expense_types
  # POST /expense_types.json
  def create
    @expense_type = ExpenseType.new(expense_type_params)

    respond_to do |format|
      if @expense_type.save
        format.html { redirect_to @expense_type, notice: 'Expense type was successfully created.' }
        format.json { render :show, status: :created, location: @expense_type }
      else
        format.html { render :new }
        format.json { render json: @expense_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expense_types/1
  # PATCH/PUT /expense_types/1.json
  def update
    respond_to do |format|
      if @expense_type.update(expense_type_params)
        format.html { redirect_to @expense_type, notice: 'Expense type was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense_type }
      else
        format.html { render :edit }
        format.json { render json: @expense_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_types/1
  # DELETE /expense_types/1.json
  def destroy
    @expense_type.destroy
    respond_to do |format|
      format.html { redirect_to expense_types_url, notice: 'Expense type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense_type
      @expense_type = ExpenseType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expense_type_params
      params.require(:expense_type).permit(:name, :description)
    end
end
