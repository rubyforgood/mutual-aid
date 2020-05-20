FactoryBot.define do
  factory :organization do
    name { Faker::Name.name }
    trait :with_location do
      association :location
    end
  end
end
