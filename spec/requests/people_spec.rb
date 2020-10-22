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
      expected, remainder = people.partition.with_index { |p, i| i < Pagy::VARS[:items] }

      expected.each do |person|
        expect(response.body).to match(/#{person.name}/)
      end

      remainder.each do |person|
        expect(response.body).to_not match(/#{person.name}/)
      end
    end
  end
end
