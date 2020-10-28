require 'rails_helper'

RSpec.describe '/', type: :request do
  it 'has landing_page_text_what populated from system_setting' do
    expected_what_text = Faker::Lorem.sentence
    new_system_setting = build(:system_setting, landing_page_text_what: expected_what_text)
    expect(SystemSetting).to receive(:first).and_return new_system_setting

    get '/'

    # TODO: assert
  end

  it 'has landing_page_text_who populated from system_setting' do
    expected_who_text = Faker::Lorem.sentence
    new_system_setting = build(:system_setting, landing_page_text_who: expected_who_text)
    expect(SystemSetting).to receive(:first).and_return new_system_setting

    get '/'

    # TODO: assert
  end

  it 'has landing_page_text_how populated from system_setting' do
    expected_how_text = Faker::Lorem.sentence
    new_system_setting = build(:system_setting, landing_page_text_how: expected_how_text)
    expect(SystemSetting).to receive(:first).and_return new_system_setting

    get '/'

    # TODO: assert
  end

  describe 'GET /version' do
    let(:version) { JSON.parse(File.read(Rails.root.join('package.json'))).dig('version') }

    it 'renders a successful response json' do
      get version_url
      expect(response).to be_successful
      json = JSON.parse(response.body)
      expect(json['subject']).to eq('version')
      expect(json['status']).to eq(version)
      expect(json['color']).to eq('blue')
    end
  end
end
