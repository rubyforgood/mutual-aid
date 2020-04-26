class PublicController < ActionController::Base
  layout 'application'

  protect_from_forgery with: :exception

  def landing_page
  end

  def community_resources
    @external_resources = ExternalResource.all
  end

end
