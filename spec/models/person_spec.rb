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
        expect(person.errors.messages).to eq({ phone: ["can't be blank"] })
      end
    end
  end
end
