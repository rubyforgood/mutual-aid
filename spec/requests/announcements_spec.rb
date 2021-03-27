require 'rails_helper'

RSpec.describe '/announcements', type: :request do
  let(:announcement) { create :announcement, is_approved: false }
  let(:params) {{ announcement: {
    name: 'Ni una mas',
    description: 'Not one more',
    publish_from: Date.current,
    is_approved: true,
  }}}

  describe 'GET /announcements' do
    it 'is accessible to guests' do
      get announcements_path
      expect(response).to be_successful
    end
  end

  describe 'GET /announcements/:id' do
    it 'is accessible to guests' do
      get announcement_path announcement
      expect(response).to be_successful
    end
  end

  describe 'GET /announcements/new' do
    it 'is accessible to guests' do
      get new_announcement_path
      expect(response).to be_successful
    end
  end

  describe 'PUT /announcements' do
    context 'as an admin' do
      before { sign_in create :user, :admin }

      it 'succeeds and redirects to /announcements' do
        expect { post announcements_path, params: params }.to change(Announcement, :count).by 1
        expect(response).to have_http_status :found
        expect(response.location).to match announcements_path
      end

      context 'with ?admin=false override' do
        it 'redirects to /thank_you' do
          post announcements_path, params: params.merge(admin: 'false')
          expect(response).to have_http_status :found
          expect(response.location).to match thank_you_path
        end
      end
    end

    context 'as a guest' do
      it 'succeeds but ignores admin params' do
        expect { post announcements_path, params: params }.to change(Announcement, :count).by 1
        expect(Announcement.last.is_approved).to be false
      end
    end
  end

  describe 'GET /announcements/:id/edit' do
    context 'as an admin' do
      before { sign_in create :user, :admin }

      it 'is accessible' do
        get edit_announcement_path announcement
        expect(response).to be_successful
      end
    end

    context 'as a neighbor' do
      before { sign_in create :user, :neighbor }

      it 'is not accessible' do
        get edit_announcement_path announcement
        expect(response).to have_http_status :forbidden
      end
    end

    context 'as a guest' do
      it 'redirects to login' do
        get edit_announcement_path announcement
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH /announcements/:id' do
    context 'as an admin' do
      before { sign_in create :user, :admin }

      it 'updates admin-only params' do
        patch announcement_path(announcement), params: params
        expect(announcement.reload.is_approved).to be true
      end
    end

    context 'as a neighbor' do
      before { sign_in create :user, :neighbor }

      it 'is not accessible' do
        patch announcement_path(announcement)
        expect(response).to have_http_status :forbidden
      end
    end
  end

  describe 'DELETE /announcements/:id' do
    context 'as an admin' do
      before { sign_in create :user, :admin }

      it 'destroys the announcement' do
        delete announcement_path(announcement)
        expect(Announcement.exists? announcement.id).to be false
      end
    end

    context 'as a neighbor' do
      before { sign_in create :user, :neighbor }

      it 'is not accessible' do
        delete announcement_path(announcement)
        expect(response).to have_http_status :forbidden
      end
    end
  end
end
