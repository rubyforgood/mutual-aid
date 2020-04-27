FactoryBot.define do
  factory :service_area do
    parent { nil }
    name { Faker::Name.name }
  end
end
