FactoryBot.define do
  factory :ask do
    type { "Ask" }

    association :person
    association :service_area

  end
end
