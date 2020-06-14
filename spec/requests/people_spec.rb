 require 'rails_helper'

RSpec.describe "/people", type: :request do
  let(:valid_attributes) {
    { name: "Pat McUser", phone: "212-555-1234", preferred_contact_method_id: create(:contact_method).id }.with_indifferent_access
  }
  let(:invalid_attributes) {
    { name: nil }
  }

  describe "GET /index" do
    subject { get people_url }

    before(:each) { create(:person) } 

    it_behaves_like "basic user authorization required" 
  end

  describe "GET /show" do
    let(:resource) { create(:person) }
    subject { get person_url(resource) }

    it_behaves_like "basic user authorization required"
  end

  describe "GET /new" do
    subject { get new_person_url }

    it_behaves_like "basic user authorization required"
  end

  describe "GET /edit" do
    context "when editing your own record" do
      let(:resource) { create(:user, :with_person) }
      subject { get edit_person_url(resource.person) }

      it_behaves_like 'redirects without authorization'

      # No easy way to use the shared example, so just do it inline
      it "renders successfully when signed-in" do
        sign_in(resource)
        subject
        expect(response).to be_successful
      end
    end

    context "When editing another user's record" do
      let(:resource) { create(:person) }
      subject { get edit_person_url(resource) }

      it_behaves_like "redirects without authorization"
      it_behaves_like "disallowed behavior as", [:user, :with_person]
      it_behaves_like "successful with admin user authorization"
    end
  end

  describe "POST /create" do
    subject { post people_url, params: { person: valid_attributes } }

    it_behaves_like "basic user authorization required"

    context "when the user already has a person record for themselves" do
      let(:self) { create(:user) }
      subject { post people_url, params: { person: valid_attributes.merge(user_id: self.id) } }

      before(:each) { create(:person, user_id: self.id) }

      # TODO: What happens when the user already has a record created for themselves
    end

    context "when attempting to create a person for someone else's user ID" do
      let(:other_user) { create(:user) }
      subject { post people_url, params: { person: valid_attributes.merge(user_id: other_user.id) } }

      it "does not do this and renders forbidden" do
        sign_in(create(:user))

        expect{subject}.not_to change(Person, :count)
        expect(response).to be_forbidden
      end

    end

    context "with invalid parameters" do
      subject { post people_url, params: { person: invalid_attributes } }

      it "does not create a new person and re-renders the new page" do
        sign_in(create(:user))

        expect{subject}.not_to change(Person, :count)
        expect(response).to be_successful
      end
    end

    context "While signed-in as a SysAdmin" do
      before(:each) { sign_in(create(:user, :sys_admin)) }
      let(:other_user) { create(:user) }

      context "with valid parameters for any user" do

        it "creates a new record and redirects to the index" do
          expect {
            post people_url, params: { person: valid_attributes.merge(user_id: other_user.id) }
          }.to change(Person, :count).by(1)
          expect(response).to redirect_to(url_for(root_path(default_url_options)))
        end
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

  fdescribe "DELETE /destroy" do
    subject { create(:user) }

    it_behaves_like "redirects without authorization"
    
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
