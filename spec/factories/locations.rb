FactoryBot.define do
  factory :location do
    association :location_type
  end
end

# == Schema Information
#
# Table name: locations
#
#  id               :bigint           not null, primary key
#  city             :string
#  county           :string
#  neighborhood     :string
#  region           :string
#  state            :string(2)
#  street_address   :string
#  zip              :string(5)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  location_type_id :bigint           not null
#
# Indexes
#
#  index_locations_on_location_type_id  (location_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_type_id => location_types.id)
#
