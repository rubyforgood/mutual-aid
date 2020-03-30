FactoryBot.define do
  factory :listing do
    title { "Randomly Generated Listing" }
    description { "A Description" }
    type { %w(Offering Resource Need).sample }
    zip { "10101" }

    factory :offering do
      title { "An Offering" }
      type { "Offering" }
    end

    factory :resource do
      title { "A Community Resource" }
      type { "Resource" }
    end

    factory :need do
      title { "A Request" }
      type { "Need" }
    end
  end
end
