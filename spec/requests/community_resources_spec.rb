require 'rails_helper'

RSpec.describe '/community_resources', type: :request do
  let(:community_resource) { create :community_resource }

  let(:params) {{ community_resource: {
    name: 'Free Breakfast Program',
    description: 'Food for the rev!',
    publish_from: Date.current,
    organization_attributes: { name: 'Black Panther Party' },
    location: {
      street_address: '123 Sesame Street',
      city: 'Kings Park',
      state: 'NY',
      zip: '11754',
      location_type_id: 1
    }
  }}}

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
    context 'as an admin' do
      before { sign_in create :user, :admin }

      it 'succeeds and redirects to /community_resources' do
        expect { post community_resources_path, params: params }.to change(CommunityResource, :count).by 1
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

      it 'creates a new community resource and location' do
        expect { post community_resources_path, params: params }.to(
          change(CommunityResource, :count).by(1).and(
          change(Location, :count).by(1)
        ))
      end

      context 'when a matching location already exists' do
        let(:location_attrs) {{
          street_address: '42 existing location',
          location_type_id: 1,
        }}

        before do
          Location.create! location_attrs
        end

        it 'creates a new community resource using the existing location' do
          params[:community_resource][:location] = location_attrs

          expect { post community_resources_path, params: params }.to(
            change(CommunityResource, :count).by(1).and(
            change(Location, :count).by(0)
          ))
        end
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
