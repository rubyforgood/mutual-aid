 require 'rails_helper'

RSpec.describe "/users", type: :request do
  let(:valid_attributes) {
    { email: "username@domain.com", password: "password", password_confirmation: "password" }.with_indifferent_access
  }

  let(:invalid_attributes) {
    { email: nil }
  }

  describe "GET /index" do
    before(:each) { sign_in(create(:user)) }

    it "renders a successful response" do
      User.create! valid_attributes
      get users_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    before(:each) { sign_in(create(:user)) }

    it "renders a successful response" do
      user = User.create! valid_attributes
      get user_url(user)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    before(:each) { sign_in(create(:user)) }

    it "renders a successful response" do
      get new_user_url(resource: User.new)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    subject { create(:user) }

    context "When editing your own record" do
      before(:each) { sign_in(subject) }

      it "render a successful response" do
        get edit_user_url(subject)
        expect(response).to redirect_to(edit_user_registration_path(default_url_options))
      end
    end

    context "When editing another user's record" do
      context "As a regular user" do
        before(:each) { sign_in(create(:user)) }

        it "disallows you from editing another user's record" do
          get edit_user_url(subject)
          expect(response).not_to be_successful
        end
      end

      context "As an admin" do
        before(:each) { sign_in(create(:user,   :admin)) }

        it "allows you to edit another user's record" do
          get edit_user_url(subject)
          expect(response).to be_successful
        end
      end
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new user and redirects to the index" do
        expect {
          post users_url, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
        expect(response).to redirect_to(url_for(root_path(default_url_options)))
      end
    end

    context "with invalid parameters" do
      it "does not create a new subject and renders a new template" do
        expect {
          post users_url, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    subject { create(:user) }

    let(:new_attributes) {
      { email: "different_" + valid_attributes["email"] }
    }
    let(:invalid_new_attributes) {
      { email: "bademail" }
    }

    context "As any other user" do
      before(:each) { sign_in(create(:user)) }
      it "disallows access" do
        patch user_url(subject), params: { user: new_attributes }
        expect(response).not_to be_successful
        expect(flash[:error]).to be_present
      end
    end

    context "As the user themselves" do
      before(:each) { sign_in(subject) }

      context "with valid parameters" do
        it "updates the requested user and redirects to their profile" do
          expect do
            patch user_url(subject), params: { user: new_attributes }
            subject.reload
          end.to change{subject.updated_at}
          expect(response).to redirect_to(users_url(default_url_options))
        end
      end

      context "with invalid parameters" do
        it "renders a successful response" do
          patch user_url(subject), params: { user: invalid_new_attributes }
          expect(response).to be_successful
        end
      end
    end

    context "As a SysAdmin" do
      before(:each) { sign_in(create(:user, :sys_admin)) }

      context "with valid parameters" do
        it "updates the requested user and redirects to their profile" do
          expect do
            patch user_url(subject), params: { user: new_attributes }
            subject.reload
          end.to change{subject.updated_at}
          expect(response).to redirect_to(users_url(default_url_options))
        end
      end

      context "with invalid parameters" do
        it "renders a successful response" do
          patch user_url(subject), params: { user: invalid_new_attributes }
          expect(response).to be_successful
        end
      end
    end
  end

  describe "DELETE /destroy" do
    subject { create(:user) }

    context "As a regular user" do
      before(:each) { sign_in(create(:user)) }

      it "does not destroy a user" do
        expect {
          delete user_url(subject)
        }.not_to change(User, :count)
        expect(response).not_to be_successful
      end
    end

    context "As a SysAdmin" do
      before(:each) { sign_in(create(:user, :sys_admin)) }

      it "destroys the requested user and redirects to the users list" do
        user = User.create! valid_attributes
        expect {
          delete user_url(user)
        }.to change(User, :count).by(-1)
        expect(response).to redirect_to(users_url(default_url_options))
      end
    end
  end
end
