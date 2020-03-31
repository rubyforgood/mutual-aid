FactoryBot.define do
  factory :listing do
    type { %w(Offering Resource Need).sample }
    zip { "10101" }

    factory :offering, class: "Offering" do
      type { "Offering" }
    end

    factory :resource, class: "Resource" do
      type { "Resource" }
    end

    factory :need, class: "Need" do
      type { "Need" }
    end
  end
end
