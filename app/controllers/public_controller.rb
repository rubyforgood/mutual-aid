class PublicController < ActionController::Base

  protect_from_forgery with: :exception
  include ApplicationHelper

  def about
  end

  def community_resources
    @admin_status = params[:admin] ? YAML.load(params[:admin]) : current_user&.admin?
    @external_resources = ExternalResource.where(approved: true).published
  end

  def landing_page
  end

  def news_and_announcements
    @announcements = Announcement.where(approved: true).published
  end

  def share
    # TODO - change current /listings endpoint to point to this one
  end

end
