require 'rails_helper'

RSpec.describe "/listings", type: :request do
  let(:valid_attributes) {{
    location_attributes: {zip: "12345"},
  }}

  let(:invalid_attributes) {{
    location_attributes: {zip: "12e45"},
  }}

  before { sign_in create(:user) }

  pending "GET /index" do
    it "renders a successful response" do
      Listing.create! valid_attributes
      get listings_url
      expect(response).to be_successful
    end
  end

  pending "GET /show" do
    it "renders a successful response" do
      listing = Listing.create! valid_attributes
      get listing_url(listing)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    before { get new_listing_url }

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "includes fields for nested models" do
      expect(response.body).to include "listing_location_attributes_street"
    end
  end

  pending "GET /edit" do
    it "render a successful response" do
      listing = Listing.create! valid_attributes
      get edit_listing_url(listing)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Listing and Location" do
        expect {
          post listings_url, params: { listing: valid_attributes }
        }.to  change(Listing, :count).by(1)
         .and change(Location, :count).by(1)
      end

      it "redirects to the created listing" do
        post listings_url, params: { listing: valid_attributes }
        expect(response).to redirect_to(listing_url(Listing.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Listing" do
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

  pending "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested listing" do
        listing = Listing.create! valid_attributes
        patch listing_url(listing), params: { listing: new_attributes }
        listing.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the listing" do
        listing = Listing.create! valid_attributes
        patch listing_url(listing), params: { listing: new_attributes }
        listing.reload
        expect(response).to redirect_to(listing_url(listing))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        listing = Listing.create! valid_attributes
        patch listing_url(listing), params: { listing: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  pending "DELETE /destroy" do
    it "destroys the requested listing" do
      listing = Listing.create! valid_attributes
      expect {
        delete listing_url(listing)
      }.to change(Listing, :count).by(-1)
    end

    it "redirects to the listings list" do
      listing = Listing.create! valid_attributes
      delete listing_url(listing)
      expect(response).to redirect_to(listings_url)
    end
  end
end
