FactoryBot.define do
  factory :service_area do
    association :location
    association :organization
    service_area_type { Faker::Name.name }
    parent { nil }
    name { Faker::Name.name }
  end
end
