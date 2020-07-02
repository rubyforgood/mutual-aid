class ExpensesController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @expenses = Expense.all
    @expenses_total = @expenses.pluck(:amount).sum
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def edit
  end

  def create
    @expense = Expense.new(expense_params)

    if @expense.save
      redirect_to expenses_path, notice: 'Expense was successfully created.'
    else
      render :new
    end
  end

  def update
    if @expense.update(expense_params)
      redirect_to expenses_path, notice: 'Expense was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_url, notice: 'Expense was successfully destroyed.'
  end

  private
  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(
      :shared_account_id,
      :processed_on,
      :name,
      :person_id,
      :expense_type_id,
      :status,
      :amount,
      :fee,
      :net,
      :transaction_id_number,
      :reference_txn_id_number,
      :note,
      :organization_id
    )
  end
end
