FactoryBot.define do
  factory :feedback do
    match { nil }
    is_from_receiver { false }
    completed { false }
    quality { 1 }
    description { "MyText" }
  end
end
