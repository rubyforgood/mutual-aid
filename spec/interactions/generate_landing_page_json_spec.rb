# frozen_string_literal: true
require 'rails_helper'

RSpec.describe GenerateLandingPageJson do
  let(:system_setting) do
    build :system_setting, {
      landing_page_text_what: 'what?',
      landing_page_text_who: 'who?',
      landing_page_text_how: 'how?',
    }
  end

  let(:organization) { build :organization, name: 'org_name' }

  subject(:json) do
    GenerateLandingPageJson.run! system_setting: system_setting, organization: organization
  end

  it 'pulls landing page text from system settings' do
    expect(JSON.parse(json)).to include(
      "landing_page_text_what" => 'what?',
      "landing_page_text_who"  => 'who?',
      "landing_page_text_how"  => 'how?'
    )
  end
end

