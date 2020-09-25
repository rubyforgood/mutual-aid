require 'rails_helper'

RSpec.describe AddPersonDetailsFromClaimParams do
  let(:preferred_contact_method) { create :contact_method }
  let(:contact_info) { "person contact info" }
  let(:person_name) { "John Doe" }

  before do
    AddPersonDetailsFromClaimParams.run!(user: user, name: person_name, preferred_contact_method_id: preferred_contact_method.id, contact_info: contact_info)
  end

  context "when person record for the user is not present" do
    let(:user) { create :user } # user without person

    it "creates a person record with given details" do
      expect(user.person).to have_attributes(
        name: person_name,
        preferred_contact_method: preferred_contact_method,
        phone: contact_info
      )
    end
  end

  context "when person record for the user is present" do
    let(:user) { create(:user, :with_person) }

    it "updates the person record with given details" do
      person = user.person
      expect(person).to have_attributes(
        name: person.name,
        preferred_contact_method: preferred_contact_method,
        phone: contact_info
      )
    end
  end
end
