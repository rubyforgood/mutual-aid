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
