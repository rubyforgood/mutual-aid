FactoryBot.define do
  factory :offer do
    type { "Offer" }

    association :person
    association :service_area

  end
end
