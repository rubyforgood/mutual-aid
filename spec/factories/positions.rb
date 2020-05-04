FactoryBot.define do
  factory :position do
    association :person
    association :organization
  end
end
