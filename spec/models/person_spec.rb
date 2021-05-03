require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'preferred_contact_method validation' do
    let(:contact_method) { build :contact_method, name: 'Text', field: 'phone' }

    subject(:person) { build :person, preferred_contact_method: contact_method }

    context 'when the preferred method field is provided' do
      before { person.phone = '123 456 1234' }

      it { is_expected.to be_valid }
    end

    context 'when the preferred method field is missing' do
      before { person.phone = nil }

      it { is_expected.not_to be_valid }

      it 'generates an error on the correct field' do
        person.valid?
        expect(person.errors.messages).to eq({phone: ["can't be blank"]})
      end
    end
  end

  describe "#anonymized_name_and_email" do
    it "returns blank if name and email are empty" do
      person = build(:person, name: nil, email: nil)

      expect(person.anonymized_name_and_email).to be_blank
    end

    it "returns just anonymized name when only name is present" do
      person = build(:person, name: "John Doe", email: nil)

      expect(person.anonymized_name_and_email).to eq("J*** D**")
    end

    it "returns just anonymized email when only email is present" do
      person = build(:person, name: nil, email: "john.doe@example.io")

      expect(person.anonymized_name_and_email).to eq("********@*******.io")
    end

    it "returns anonymized name and email" do
      person = build(:person, name: "John Doe", email: "john.doe@example.io")

      expect(person.anonymized_name_and_email).to eq("J*** D** ********@*******.io")
    end
  end
end
