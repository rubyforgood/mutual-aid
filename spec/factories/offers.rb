FactoryBot.define do
  factory :offer do
    type { %w(Offer).sample }

    association :location

    trait :with_contact_info do
      name { Faker::Name.name }
      email { Faker::Internet.email}
      phone { Faker::PhoneNumber.phone_number }
    end
  end
end
