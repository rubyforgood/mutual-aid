class PublicPagesController < PublicController
  layout "without_navbar", only: [:announcements, :community_resources]

  def about
    @about_us_text = @system_setting.about_us_text
  end

  def announcements
    @announcements = Announcement.where(is_approved: true).published
  end

  def community_resources
    @admin_status = params[:admin] ? YAML.load(params[:admin]) : current_user&.admin_role?
    @community_resources = CommunityResource.where(is_approved: true).published
  end

  def contributions
    redirect_to listings_path # TODO - change current /listings endpoint to point to this one
  end

  def landing_page
    @landing_page_text_what = @system_setting.landing_page_text_what
    @landing_page_text_who = @system_setting.landing_page_text_who
    @landing_page_text_how = @system_setting.landing_page_text_how
    @organization_name = Organization.current_organization.name
  end
end
