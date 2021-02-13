# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authorization

  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_admin_status
  before_action :set_system_setting
  around_action :switch_locale

  def set_admin_status
    # FIXME: replace uses of @admin_status with pundit
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

  def context
    @context ||= Context.new(
      user: current_user,
      admin_param: params[:admin],
    )
  end
  helper_method :context

  private

  # TODO: this appears to be unused?
  def user_not_authenticated(_exception)
    flash[:error] = 'This requires authentication, please sign-in first.'
    respond_to do |format|
      format.html { render 'devise/sessions/new.html.erb', layout: "application", status: 401 }
      format.xml  { head 401 }
      format.any  { head 401 }
    end
  end
end
