class ApplicationController < ActionController::Base
  include DeliverNowWithErrorHandling

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :admin_status
  around_action :switch_locale

  def admin_status
    @admin_status = params[:admin] ? YAML.load(params[:admin]) : current_user&.admin? # allows admin user to simulate with param=false
  end

  def switch_locale(&action)
    locale = params[:locale] || current_user.try(:locale) || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end

end
