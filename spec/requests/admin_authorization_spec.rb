require 'rails_helper'

describe 'authorization of admin-only controllers', type: :request do
  let(:sample_controller_path) { contact_methods_path }

  before { login_as user }

  describe 'as a guest' do
    let(:user) { nil }

    it 'requires login' do
      get sample_controller_path
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'as a dispatcher' do
    let(:user) { create :user, :dispatcher }

    it 'denies access' do
      get sample_controller_path
      expect(response).to have_http_status :forbidden
    end
  end

  describe 'as an admin' do
    let(:user) { create :user, :admin }

    it 'allows access' do
      get sample_controller_path
      expect(response).to be_successful
    end
  end
end
