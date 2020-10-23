require 'rails_helper'

describe '/people', type: :request do
  describe 'GET /index' do
    let!(:people) { create_list(:person, 40) }

    before do
      sign_in create(:user)
    end

    it 'renders a successful response' do
      get people_url
      expect(response).to be_successful
    end

    it 'paginates results' do
      get people_url
      people_links = response.body.scan %r{href="/people/\d+/.+"}
      expect(people_links.size).to eq Pagy::VARS[:items]
    end
  end
end
