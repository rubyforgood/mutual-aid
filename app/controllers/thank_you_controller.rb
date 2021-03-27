# frozen_string_literal: true
class ThankYouController < PublicController
  layout 'without_navbar'

  def show
    @current_organization = Organization.current_organization
    @system_setting = context.system_settings
  end
end
