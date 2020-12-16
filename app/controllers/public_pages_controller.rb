# frozen_string_literal: true

class PublicPagesController < PublicController
  layout :determine_layout

  def about
    @about_us_text = HtmlSanitizer.new(@system_setting.about_us_text).sanitize
  end

  def determine_layout
    'without_navbar' unless @system_setting.display_navbar?
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
    redirect_to listings_path # TODO: - change current /listings endpoint to point to this one
  end

  def landing_page
    @json = {
      landing_page_text_what: HtmlSanitizer.new(@system_setting.landing_page_text_what).sanitize,
      landing_page_text_who: HtmlSanitizer.new(@system_setting.landing_page_text_who).sanitize,
      landing_page_text_how: HtmlSanitizer.new(@system_setting.landing_page_text_how).sanitize,
      organization_name: Organization.current_organization.name,
    }.to_json
  end

  def version
    version = JSON.parse(File.read(Rails.root.join('package.json'))).dig('version')
    render json: {
      subject: 'version',
      status: version,
      color: 'blue'
    }
  end
end
