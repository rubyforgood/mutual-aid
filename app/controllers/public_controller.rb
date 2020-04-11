class PublicController < ActionController::Base

  protect_from_forgery with: :exception

  def landing_page
  end

end
