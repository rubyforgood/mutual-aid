FactoryBot.define do
  factory :location_type do
    name { "MyString" }
    description { "MyString" }
    display_to_public { true }
  end
end

# == Schema Information
#
# Table name: location_types
#
#  id                :bigint           not null, primary key
#  description       :string
#  display_to_public :boolean          default(FALSE), not null
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_location_types_on_display_to_public  (display_to_public)
#
