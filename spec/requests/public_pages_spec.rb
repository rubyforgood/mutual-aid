require 'rails_helper'

RSpec.describe '/', type: :request do
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
