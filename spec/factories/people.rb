FactoryBot.define do
  factory :person do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    email { Faker::Internet.email }

    trait :with_email do
      email { Faker::Internet.email }
    end

    trait :with_phone do
      phone { Faker::PhoneNumber.phone_number }
    end

    trait :with_email_and_phone do
      email { Faker::Internet.email }
      phone { Faker::PhoneNumber.phone_number }
    end

    trait :with_location do
      association :location
    end

    trait :with_location do
      association :location
    end

    trait :with_user do
      association :user
    end
  end
end
