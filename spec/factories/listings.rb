FactoryBot.define do
  factory :listing do
    type { %w(Offer Ask).sample }
    trait :with_location do
      location
    end
  end
end
