FactoryBot.define do
  factory :listing do
    title { "Randomly Generated Listing" }
    description { "A Description" }
    type { %w(Offering Resource Wish).sample }

    factory :offering do
      title { "An Offering" }
      type { "Offering" }
    end

    factory :resource do
      title { "A Community Resource" }
      type { "Resource" }
    end

    factory :wish do  
      title { "A Wish" }
      type { "Wish" }    
    end
  end
end
