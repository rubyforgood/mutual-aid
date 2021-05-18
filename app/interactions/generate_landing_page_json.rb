# frozen_string_literal: true

class GenerateLandingPageJson < ActiveInteraction::Base
  object :system_setting
  object :organization

  def execute
    {
      landing_page_text_what: sanitize(system_setting.landing_page_text_what),
      landing_page_text_who: sanitize(system_setting.landing_page_text_who),
      landing_page_text_how: sanitize(system_setting.landing_page_text_how),
      organization_name: organization.name
    }.to_json
  end

  private

  def sanitize string
    HtmlSanitizer.new(string).sanitize
  end
end
