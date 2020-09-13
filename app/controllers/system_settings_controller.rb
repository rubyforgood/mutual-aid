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
    @exchange_types = SystemSetting::EXCHANGE_TYPES
  end

  def edit
    @exchange_types = SystemSetting::EXCHANGE_TYPES
  end

  def create
    @system_setting = SystemSetting.new(system_setting_params)

    if @system_setting.save
      redirect_to system_settings_path, notice: 'System setting was successfully created.'
    else
      render :new
    end
  end

  def update
    if @system_setting.update(system_setting_params)
      redirect_to system_settings_path, notice: 'System setting was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @system_setting.destroy
    redirect_to system_settings_url, notice: 'System setting was successfully destroyed.'
  end

  private
    def set_system_setting
      @system_setting = SystemSetting.find(params[:id])
    end

    def set_primary_organization
      @primary_organization = Organization.where(is_instance_owner: true).last
    end

    def system_setting_params
      params.require(:system_setting).permit(
        :allow_sms,
        :exchange_type,
        :separate_asks_offers,
        :display_navbar,

        :announcements_module,
        :community_resources_module,
        :donations_module,
        :chat_module,
        :positions_module,
        :shared_accounts_module,

        :about_us_text,
        :confirmation_page_text_header,
        :confirmation_page_text_body,
        :confirmation_page_text_link_header,
        :confirmation_page_text_footer,
        :landing_page_text_what,
        :landing_page_text_who,
        :landing_page_text_how,
      )
    end
end
