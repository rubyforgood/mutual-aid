# frozen_string_literal: true

# FIXME: Extract actions into separate controllers or consolidate with existing ones
class PublicPagesController < PublicController
  layout :determine_layout

  def about
    @about_us_text = HtmlSanitizer.new(@system_setting.about_us_text).sanitize
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

  private

  def determine_layout
    'without_navbar' unless @system_setting.display_navbar?
  end
end
