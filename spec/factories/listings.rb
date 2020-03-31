FactoryBot.define do
  factory :listing do
    type { %w(Offering Resource Ask).sample }

    association :location

    factory :offering, class: "Offering" do
      type { "Offering" }
    end

    factory :resource, class: "Resource" do
      type { "Resource" }
    end

    factory :ask, class: "Ask" do
      type { "Ask" }
    end
  end
end
