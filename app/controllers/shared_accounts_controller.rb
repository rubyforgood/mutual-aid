class SharedAccountsController < ApplicationController
  before_action :set_shared_account, only: [:show, :edit, :update, :destroy]

  # GET /shared_accounts
  # GET /shared_accounts.json
  def index
    @shared_accounts = SharedAccount.all
  end

  # GET /shared_accounts/1
  # GET /shared_accounts/1.json
  def show
  end

  # GET /shared_accounts/new
  def new
    @shared_account = SharedAccount.new
  end

  # GET /shared_accounts/1/edit
  def edit
  end

  # POST /shared_accounts
  # POST /shared_accounts.json
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

  # PATCH/PUT /shared_accounts/1
  # PATCH/PUT /shared_accounts/1.json
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

  # DELETE /shared_accounts/1
  # DELETE /shared_accounts/1.json
  def destroy
    @shared_account.destroy
    respond_to do |format|
      format.html { redirect_to shared_accounts_url, notice: 'Shared account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shared_account
      @shared_account = SharedAccount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shared_account_params
      params.require(:shared_account).permit(:name, :account_url, :username, :password_hint, :notes)
    end
end
