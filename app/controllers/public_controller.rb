class PublicController < ActionController::Base
  layout 'application'

  protect_from_forgery with: :exception
  include ApplicationHelper

  def about
    @about_us_text = @system_setting.about_us_text
  end

  def community_resources
    @admin_status = params[:admin] ? YAML.load(params[:admin]) : current_user&.admin?
    @community_resources = CommunityResource.where(is_approved: true).published
  end

  def landing_page
  end

  def news_and_announcements
    @announcements = Announcement.where(is_approved: true).published
  end

  def share
    # TODO - change current /listings endpoint to point to this one
  end

end
