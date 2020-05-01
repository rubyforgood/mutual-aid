FactoryBot.define do
  factory :listing do
    type { %w(Offer Ask).sample }
    association :person
    association :service_area

    trait :with_location do
      location
    end
  end
end
