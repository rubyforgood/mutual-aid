class SystemSettingsController < ApplicationController
  before_action :set_system_setting, only: [:show, :edit, :update, :destroy]
  before_action :set_primary_organization, only: [:show, :edit, :update, :destroy]

  def index
    @system_settings = SystemSetting.all
  end

  def show
  end

  def new
    @system_setting = SystemSetting.new
  end

  def edit
  end

  def create
    @system_setting = SystemSetting.new(system_setting_params)

    respond_to do |format|
      if @system_setting.save
        format.html { redirect_to system_settings_path, notice: 'System setting was successfully created.' }
        format.json { render :show, status: :created, location: @system_setting }
      else
        format.html { render :new }
        format.json { render json: @system_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @system_setting.update(system_setting_params)
        format.html { redirect_to system_settings_path, notice: 'System setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @system_setting }
      else
        format.html { render :edit }
        format.json { render json: @system_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @system_setting.destroy
    respond_to do |format|
      format.html { redirect_to system_settings_url, notice: 'System setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_system_setting
      @system_setting = SystemSetting.find(params[:id])
    end

    def set_primary_organization
      @primary_organization = Organization.where(is_instance_owner: true).last
    end

    def system_setting_params
      params.require(:system_setting).permit(:exchange_type, :separate_asks_offers, :allow_sms, :community_resources_module, :announcements_module, :positions_module, :donations_module, :shared_accounts_module, :chat_module, :landing_page_text_what, :landing_page_text_who, :landing_page_text_how)
    end
end
