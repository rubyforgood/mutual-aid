require 'rails_helper'

RSpec.describe "/contributions", type: :request do
  let(:valid_attributes) {{
      location_attributes: {zip: "12345"},
      tag_list: ["", "cash"],
      # name: Faker::Name.name,
      # email: Faker::Internet.email,
      # phone: Faker::PhoneNumber.phone_number
  }}

  let(:invalid_attributes) {{
      location_attributes: {zip: "12e45"},
  }}

  before { sign_in create(:user) }

  describe "GET /index" do
    it "renders a successful response" do
      create(:listing)
      get contributions_public_url
      expect(response).to be_successful
    end
  end

end
