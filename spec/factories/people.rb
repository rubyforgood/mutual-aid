FactoryBot.define do
  factory :person do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    preferred_contact_method { association :contact_method_email }

    trait :with_email do
      preferred_contact_method { "email" }
      email { Faker::Internet.email }
    end

    trait :with_phone do
      preferred_contact_method { association :contact_method_phone }
      phone { Faker::PhoneNumber.phone_number }
    end

    trait :with_email_and_phone do
      preferred_contact_method { "email" }
      email { Faker::Internet.email }
      phone { Faker::PhoneNumber.phone_number }
    end

    trait :with_location do
      association :location
    end

    trait :with_service_area do
      association :service_area
    end

    trait :with_user do
      association :user
    end
  end
end

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
