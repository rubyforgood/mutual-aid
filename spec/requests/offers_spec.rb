require 'rails_helper'

RSpec.describe '/listings', type: :request do
  let(:service_area) { create(:service_area) }

  let(:valid_attributes) {{
    service_area_id: service_area.id,
    person_attributes: {
      email: 'new_address@example.com',
      preferred_contact_method: 'email',
    },
  }}

  let(:invalid_attributes) {{
    description: 'is not enough!',
  }}

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Listing and nested Person' do
        expect {
          post offers_url, params: { listing: valid_attributes }
        }.to  change(Listing, :count).by(1)
         .and change(Person, :count).by(1)
      end

      it 'redirects to the created listing' do
        post offers_url, params: { listing: valid_attributes }
        expect(response).to redirect_to(root_path({locale: 'en'}))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Listing' do
        expect {
          post offers_url, params: { listing: invalid_attributes }
        }.not_to change(Listing, :count)
      end

      it 'renders a successful response (i.e. to display the /new template)' do
        post offers_url, params: { listing: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
