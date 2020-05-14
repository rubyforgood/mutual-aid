class PublicPagesController < PublicController

  def about
    @about_us_text = @system_setting.about_us_text
  end

  def announcements
    @announcements = Announcement.where(is_approved: true).published
  end

  def community_resources
    @admin_status = params[:admin] ? YAML.load(params[:admin]) : current_user&.admin?
    @community_resources = CommunityResource.where(is_approved: true).published
  end

  def contributions
    redirect_to listings_path # TODO - change current /listings endpoint to point to this one
  end

  def combined_form
  end

  def landing_page
  end
end
