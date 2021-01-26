require 'rails_helper'

RSpec.describe '/listings', type: :request do
  let(:valid_attributes) {{
    location_attributes: { zip: '12345' },
    tag_list: ['', 'cash'],
    # name: Faker::Name.name,
    # email: Faker::Internet.email,
    # phone: Faker::PhoneNumber.phone_number
  }}

  let(:invalid_attributes) {{
    location_attributes: { zip: '12e45' },
  }}

  before { sign_in create(:user, :admin) }

  describe 'GET /index' do
    it 'renders a successful response' do
      create(:listing)
      get listings_url
      expect(response).to be_successful
    end

    # it 'allows asking for a specific subtype of listing' do
    #   ask = create(:ask, title: 'this is the ask title')
    #   offer = create(:offer, title: 'this is the offer title')
    #   get listings_url, params: {ContributionType: {'Ask' => 1}}
    #   expect(response.body).to match(ask.title)
    #   expect(response.body).not_to match(offer.title)
    #   get listings_url, params: {ContributionType: {'Offer' => 1}}
    #   expect(response.body).not_to match(ask.title)
    #   expect(response.body).to match(offer.title)
    #   get listings_url, params: {ContributionType: {'Ask' => 1, 'Offer' => 1}}
    #   expect(response.body).to match(ask.title)
    #   expect(response.body).to match(offer.title)
    # end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      listing = create(:listing, :with_location)
      get listing_url(listing)
      expect(response).to be_successful
    end

    it 'renders a response for a listing without a location' do
      # pending "TODO: this doesn't work yet"
      listing = create(:listing)
      get listing_url(listing)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    before { get new_listing_url }

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'includes fields for nested models' do
      skip # TODO: - fixme
      expect(response.body).to include 'listing_location_attributes_street'
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      listing = create(:listing)
      get edit_listing_url(listing)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Listing and Location' do
        pending 'relationship between contribution form and addresses is tbd'
        expect {
          post listings_url, params: { listing: valid_attributes }
        }.to  change(Listing, :count).by(1)
         .and change(Location, :count).by(1)
      end

      it 'redirects to the created listing' do
        pending 'relationship between contribution form and addresses is tbd'
        post listings_url, params: { listing: valid_attributes }
        expect(response).to redirect_to(listing_url(Listing.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Listing' do
        expect {
          post listings_url, params: { listing: invalid_attributes }
        }.to change(Listing, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post listings_url, params: { listing: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    let(:listing) { create(:listing) }

    context 'with valid parameters' do
      let(:new_street_address) { Faker::Address.street_address }
      let(:new_attributes) {{
        location_attributes: { street_address: new_street_address, zip: Faker::Address.zip(state_abbreviation: 'MI') },
      }}

      before do
        # patch listing_url(listing), params: { listing: new_attributes }
      end

      it 'updates the requested listing' do
        pending 'relationship between contribution form and addresses is tbd'
        expect(listing.reload.location.street_address).to eq(new_street_address)
      end

      it 'redirects to the listing' do
        pending 'relationship between contribution form and addresses is tbd'
        expect(response).to redirect_to(listing_url(listing))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        pending 'relationship between contribution form and addresses is tbd'
        patch listing_url(listing), params: { listing: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  pending 'DELETE /destroy' do
    it 'destroys the requested listing' do
      listing = Listing.create! valid_attributes
      expect {
        delete listing_url(listing)
      }.to change(Listing, :count).by(-1)
    end

    it 'redirects to the listings list' do
      listing = Listing.create! valid_attributes
      delete listing_url(listing)
      expect(response).to redirect_to(listings_url)
    end
  end
end
