FactoryBot.define do
  factory :ask do
    type { %w(Offer).sample }

    association :location

  end
end
