FactoryBot.define do
  factory :ServiceArea do
    parent { nil }
    name { Faker::Name.name }
  end
end
