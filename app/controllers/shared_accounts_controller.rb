# frozen_string_literal: true

class SharedAccountsController < AdminController
  before_action :set_shared_account, only: %i[show edit update destroy]

  def index
    @shared_accounts = SharedAccount.all
  end

  def show; end

  def new
    @shared_account = SharedAccount.new
  end

  def edit; end

  def create
    @shared_account = SharedAccount.new(shared_account_params)

    if @shared_account.save
      redirect_to shared_accounts_path, notice: 'Shared account was successfully created.'
    else
      render :new
    end
  end

  def update
    if @shared_account.update(shared_account_params)
      redirect_to shared_accounts_path, notice: 'Shared account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @shared_account.destroy
    redirect_to shared_accounts_url, notice: 'Shared account was successfully destroyed.'
  end

  private

    def set_shared_account
      @shared_account = SharedAccount.find(params[:id])
    end

    def shared_account_params
      params.require(:shared_account).permit(:name, :account_url, :username, :password_hint, :notes)
    end
end
