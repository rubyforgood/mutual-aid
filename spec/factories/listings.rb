FactoryBot.define do
  factory :listing do
    location
    type { %w(Offer Ask).sample }
  end
end
