class PublicController < ActionController::Base

  protect_from_forgery with: :exception

  def landing_page
  end

  def community_resources
    @external_resources = ExternalResource.all
  end

end
