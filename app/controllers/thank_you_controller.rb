# frozen_string_literal: true
class ThankYouController < PublicController
  layout 'without_navbar'

  def show
    @organization = Organization.instance_owner
    @system_setting = context.system_settings
  end
end
