class SharedAccountsController < ApplicationController
  before_action :set_shared_account, only: [:show, :edit, :update, :destroy]

  def index
    @shared_accounts = SharedAccount.all
  end

  def show
  end

  def new
    @shared_account = SharedAccount.new
  end

  def edit
  end

  def create
    @shared_account = SharedAccount.new(shared_account_params)

    respond_to do |format|
      if @shared_account.save
        format.html { redirect_to shared_accounts_path, notice: 'Shared account was successfully created.' }
        format.json { render :show, status: :created, location: @shared_account }
      else
        format.html { render :new }
        format.json { render json: @shared_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @shared_account.update(shared_account_params)
        format.html { redirect_to shared_accounts_path, notice: 'Shared account was successfully updated.' }
        format.json { render :show, status: :ok, location: @shared_account }
      else
        format.html { render :edit }
        format.json { render json: @shared_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @shared_account.destroy
    respond_to do |format|
      format.html { redirect_to shared_accounts_url, notice: 'Shared account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_shared_account
      @shared_account = SharedAccount.find(params[:id])
    end

    def shared_account_params
      params.require(:shared_account).permit(:name, :account_url, :username, :password_hint, :notes)
    end
end
