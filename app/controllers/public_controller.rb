class PublicController < ActionController::Base

  protect_from_forgery with: :exception
  render layout: "application"
  include ApplicationHelper

  def about
  end

  def community_resources
    @admin_status = params[:admin] ? YAML.load(params[:admin]) : current_user&.admin?
    @external_resources = ExternalResource.all
  end

  def landing_page
  end

  def news_and_announcements
  end

  def share
    # TODO - change current /listings endpoint to point to this one
  end

end
