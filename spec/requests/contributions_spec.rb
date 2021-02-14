require 'rails_helper'

RSpec.describe '/contributions', type: :request do
  let(:valid_attributes) {{
    location_attributes: { zip: '12345' },
    tag_list: ['', 'cash'],
  }}

  let(:invalid_attributes) {{
    location_attributes: { zip: '12e45' },
  }}

  let(:user) { create(:user) }

  describe 'access' do
    describe 'when logged in' do
      before do
        sign_in user
      end

      it 'index is accessible' do
        get contributions_url
        expect(response).to be_successful
      end

      it 'show is accessible' do
        contribution = create(:listing)
        get contribution_url(contribution)
        expect(response).to be_successful
      end
    end

    describe 'when logged out but p2p is enabled' do
      before do
        allow_any_instance_of(SystemSetting).to receive(:peer_to_peer?).and_return(true)
      end

      it 'index is accessible' do
        get contributions_url
        expect(response).to be_successful
      end

      # TODO: change this behavior once Pundit is more thoroughly set up
      it 'show is accessible' do
        listing = create(:listing)
        get contributions_url
        expect(response.body).to match(/#{contribution_path(listing.id)}/)
      end
    end

    describe 'when logged out and p2p is disabled' do
      before do
        allow_any_instance_of(SystemSetting).to receive(:peer_to_peer?).and_return(false)
      end

      it 'index requires login' do
        get contributions_url
        assert_redirected_to new_user_session_url
      end

      it 'show requires login' do
        contribution = create(:listing)
        get contribution_url(contribution)
        assert_redirected_to new_user_session_url
      end
    end

    it 'allows asking for a specific subtype of listing' do
      sign_in user
      ask = create(:ask, title: 'this is the ask title')
      offer = create(:offer, title: 'this is the offer title')
      get contributions_url, params: { ContributionType: { 'Ask' => 1 } }
      expect(response.body).to match(ask.title)
      expect(response.body).not_to match(offer.title)
      get contributions_url, params: { ContributionType: { 'Offer' => 1 } }
      expect(response.body).not_to match(ask.title)
      expect(response.body).to match(offer.title)
      get contributions_url, params: { ContributionType: { 'Ask' => 1, 'Offer' => 1 } }
      expect(response.body).to match(ask.title)
      expect(response.body).to match(offer.title)
    end

    it 'parses requests for a filtered list' do
      sign_in user
      categories = [
        create(:category, name: Faker::Lorem.word),
        create(:category, name: Faker::Lorem.word)
      ]
      both_tags_listing = create(:listing, tag_list: categories.map(&:name))
      expected_area = both_tags_listing.service_area
      expected_area.name = Faker::Address.community
      expected_area.save!
      one_tag_listing = create(:listing, service_area: expected_area, tag_list: categories.sample.name)
      both_tags_wrong_area_listing = create(:listing, tag_list: categories.map(&:name))
      no_tags_correct_area_listing = create(:listing, service_area: expected_area)

      # passing `as: json` to `get` does some surprising things to the request and its params that would break this test
      get contributions_url, {
        params: { "Category[#{categories[0].id}]": 1, "Category[#{categories[1].id}]": 1, "ServiceArea[#{expected_area.id}]": 1 },
        headers: { 'HTTP_ACCEPT' => 'application/json' }
      }

      expect(response.body).to match(/#{expected_area.name.to_json}/)

      response_ids = JSON.parse(response.body).map { |hash| hash['id']}
      expect(response_ids).to include(both_tags_listing.id)
      expect(response_ids).to include(one_tag_listing.id)
      expect(response_ids).not_to include(both_tags_wrong_area_listing.id)
      expect(response_ids).not_to include(no_tags_correct_area_listing.id)
    end
  end
end
