# FIXME: remove this when the pundit work is ready, #514
# Devise override based on https://stackoverflow.com/a/8291318
class RegistrationsSansSignupController < Devise::RegistrationsController
  def new
    redirect_to new_user_session_path,
      notice: 'Registrations have been temporarily disabled. Please check back soon or contact the app administrator'
  end

  def create
    redirect_to new_user_session_path,
      notice: 'Registrations have been temporarily disabled. Please check back soon or contact the app administrator'
  end
end
