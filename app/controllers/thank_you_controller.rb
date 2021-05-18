# frozen_string_literal: true

class ThankYouController < PublicController
  layout 'without_navbar'

  def show
    @organization = context.host_organization
    @system_setting = context.system_settings
  end
end
