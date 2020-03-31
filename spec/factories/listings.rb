FactoryBot.define do
  factory :listing do
    type { %w(Offer Ask).sample }

    association :location

    factory :offer, class: "Offer" do
      type { "Offer" }
    end

    factory :ask, class: "Ask" do
      type { "Ask" }
    end
  end
end
