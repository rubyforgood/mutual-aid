FactoryBot.define do
  factory :listing do
    location
    service_area
    type { %w(Offer Ask).sample }
  end
end
