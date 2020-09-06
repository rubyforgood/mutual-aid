# == Schema Information
#
# Table name: people
#
#  id                          :bigint           not null, primary key
#  email                       :string
#  email_2                     :string
#  monthly_donation_amount_max :float            default(0.0)
#  monthly_matches_max         :integer          default(0)
#  name                        :string
#  notes                       :text
#  phone                       :string
#  phone_2                     :string
#  preferred_contact_timeframe :string
#  preferred_locale            :string           default("en"), not null
#  skills                      :text
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  location_id                 :bigint
#  preferred_contact_method_id :integer
#  service_area_id             :bigint
#  user_id                     :bigint
#
# Indexes
#
#  index_people_on_location_id      (location_id)
#  index_people_on_service_area_id  (service_area_id)
#  index_people_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#  fk_rails_...  (service_area_id => service_areas.id)
#  fk_rails_...  (user_id => users.id)
#
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
end
