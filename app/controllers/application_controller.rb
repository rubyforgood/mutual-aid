class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_admin_status
  before_action :set_system_setting
  around_action :switch_locale

  def set_admin_status
    @admin_status = params[:admin] ? YAML.load(params[:admin]) : current_user&.admin_role? # allows admin user to simulate with param=false
  end

  def set_system_setting
    @system_setting = SystemSetting.first || SystemSetting.create! # should only be one of these records per instance
  end

  def switch_locale(&action)
    locale = params[:locale] || current_user.try(:preferred_locale) || I18n.default_locale
    @system_locale = SystemLocale.where(locale: locale.to_s).first
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
