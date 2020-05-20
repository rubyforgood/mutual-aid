FactoryBot.define do
  factory :shift_match do
    association :shift
    association :match
    notes { "MyString" }
  end
end
