FactoryBot.define do
  factory :service_area do
    association :location
    parent { nil }
    name { Faker::Name.name }
  end
end
