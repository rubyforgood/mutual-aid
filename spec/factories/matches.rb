FactoryBot.define do
  factory :match do

    association :provider
    association :receiver

    trait :with_ask_and_offer do
      association :provider, factory: :offer
      association :receiver, factory: :ask
    end

  end
end