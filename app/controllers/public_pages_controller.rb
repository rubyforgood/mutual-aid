class PublicPagesController < PublicController
  layout :determine_layout

  def about
    @about_us_text = HtmlSanitizer.new(@system_setting.about_us_text).sanitize_for_rails
  end

  def determine_layout
    "without_navbar" unless @system_setting.display_navbar?
  end

  def announcements
    @announcements = Announcement.where(is_approved: true).published
    respond_to do |format|
      format.html
      format.json { render json: @announcements }
    end
  end

  def community_resources
    @admin_status = params[:admin] ? YAML.load(params[:admin]) : current_user&.admin_role?
    @community_resources = CommunityResource.where(is_approved: true).published
  end

  def contributions
    redirect_to listings_path # TODO - change current /listings endpoint to point to this one
  end

  def landing_page
    @landing_page_text_what = HtmlSanitizer.new(@system_setting.landing_page_text_what).sanitize_for_vue
    @landing_page_text_who = HtmlSanitizer.new(@system_setting.landing_page_text_who).sanitize_for_vue
    @landing_page_text_how = HtmlSanitizer.new(@system_setting.landing_page_text_how).sanitize_for_vue
    @organization_name = Organization.current_organization.name
  end
end
