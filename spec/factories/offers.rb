FactoryBot.define do
  factory :offer do
    type { %w(Offer).sample }

    association :location

  end
end
