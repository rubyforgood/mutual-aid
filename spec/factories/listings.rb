FactoryBot.define do
  factory :listing do
    type { %w(Offer Resource Ask).sample }

    association :location

    factory :offer, class: "Offer" do
      type { "Offer" }
    end

    factory :resource, class: "Resource" do
      type { "Resource" }
    end

    factory :ask, class: "Ask" do
      type { "Ask" }
    end
  end
end
