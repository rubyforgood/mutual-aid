require 'rails_helper'

RSpec.describe "/new_user", type: :request do



  # is the user there
  # if so, tell admin this email already has an account
  # check if name matches associated person (if there is a person)
  # otherwise, check if person exists with that email
  # if person exists, check if name matches, and if so: already in the system
  # if name doesn't match, prompt: (user already in system with another name. only one account per email.)
  # if person doesn't exist, then create them and connect to this user
  # if new user, run confirmation email command
  # return to users index
  #
  # name: Faker::Name.name,
  #
  describe "POST /create" do
    context "user already exists" do
      let(:email) { Faker::Internet.email }

      it "it doesn't create a new user" do
        user = User.new(email: email)
        user.save(validate: false)

        expect {
          post admin_new_user_url(user)
        }.to_not change(User, :count)
      end
      it "redirects to form with error message" do

      end
    end
  end

  #
  # let(:invalid_attributes) {
  #   skip("Add a hash of attributes invalid for your model")
  # }
  #
  #
  # describe "GET /new" do
  #   it "renders a successful response" do
  #     get new_contact_method_url
  #     skip # TODO
  #     expect(response).to be_successful
  #   end
  # end
  #
  # describe "POST /create" do
  #   context "with valid parameters" do
  #     it "creates a new ContactMethod" do
  #       expect {
  #         post contact_methods_url, params: { contact_method: valid_attributes }
  #       }.to change(ContactMethod, :count).by(1)
  #     end
  #
  #     it "redirects to the created contact_method" do
  #       post contact_methods_url, params: { contact_method: valid_attributes }
  #       expect(response).to redirect_to(contact_method_url(ContactMethod.last))
  #     end
  #   end
  #
  #   context "with invalid parameters" do
  #     it "does not create a new ContactMethod" do
  #       expect {
  #         post contact_methods_url, params: { contact_method: invalid_attributes }
  #       }.to change(ContactMethod, :count).by(0)
  #     end
  #
  #     it "renders a successful response (i.e. to display the 'new' template)" do
  #       post contact_methods_url, params: { contact_method: invalid_attributes }
  #       expect(response).to be_successful
  #     end
  #   end
  # end
end
