class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :admin_status

  def admin_status
    @admin_status = params[:admin] ? YAML.load(params[:admin]) : current_user&.admin? # allows admin user to simulate with param=false
  end

end
