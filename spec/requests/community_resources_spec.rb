require 'rails_helper'

RSpec.describe '/community_resources', type: :request do
  let!(:location_type) { create :location_type }
  let(:community_resource) { create :community_resource }

  let(:params) do
    {community_resource: {
      name: 'Free Breakfast Program',
      description: 'Food for the rev!',
      'publish_from(1i)' => '2020',
      'publish_from(2i)' => '12',
      'publish_from(3i)' => '31',
      organization_attributes: {name: 'Black Panther Party'},
      location: {
        street_address: '123 Sesame Street',
        city: 'Kings Park',
        state: 'NY',
        zip: '11754',
        location_type: location_type.id,
      }
    }}
  end

  describe 'GET /community_resources' do
    before { create_list :community_resource, 2 }
    it 'is publicly accessible' do
      get community_resources_path
      expect(response).to be_successful
    end
  end

  describe 'GET /community_resource/:id' do
    it 'is publicly accessible' do
      get community_resource_path community_resource
      expect(response).to be_successful
    end
  end

  describe 'GET /community_resources/new' do
    it 'is publicly accessible' do
      get new_community_resource_path
      expect(response).to be_successful
    end
  end

  describe 'PUT /community_resources' do
    it 'creates a new community resource and location' do
      expect { post community_resources_path, params: params }
        .to  change(CommunityResource, :count).by(1)
        .and change(Location, :count).by(1)
    end

    context 'as an admin' do
      before { sign_in create :user, :admin }

      it 'redirects to /community_resources' do
        post community_resources_path, params: params
        expect(response).to have_http_status :found
        expect(response.location).to match community_resources_path
      end

      context 'with ?admin=false override' do
        it 'redirects to /thank_you' do
          post community_resources_path, params: params.merge(admin: 'false')
          expect(response).to have_http_status :found
          expect(response.location).to match thank_you_path
        end
      end
    end

    context 'as a guest' do
      it 'redirects to the thank you page' do
        post community_resources_path, params: params
        expect(response).to have_http_status :found
        expect(response.location).to match thank_you_path
      end
    end
  end

  describe 'GET /community_resources/:id/edit' do
    context 'as an admin' do
      before { sign_in create :user, :admin }

      it 'is accessible' do
        get edit_community_resource_path community_resource
        expect(response).to be_successful
      end
    end

    context 'as a guest' do
      it 'redirects to login' do
        get edit_community_resource_path community_resource
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH /community_resources/:id' do
    context 'as an admin' do
      before { sign_in create :user, :admin }

      it 'is successful' do
        params[:community_resource][:description] = 'changed'
        patch community_resource_path(community_resource), params: params
        expect(community_resource.reload.description).to eq 'changed'
      end
    end

    context 'as a guest' do
      it 'is not accessible' do
        patch community_resource_path(community_resource)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end


  describe 'DELETE /community_resource/:id' do
    context 'as an admin' do
      before { sign_in create :user, :admin }

      it 'destroys the announcement' do
        delete community_resource_path(community_resource)
        expect(Announcement.exists? community_resource.id).to be false
      end
    end

    context 'as a guest' do
      it 'is not accessible' do
        delete community_resource_path(community_resource)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
