FactoryBot.define do
  factory :service_area, aliases: [:locationable] do
    parent { nil }
    name { Faker::Name.name }
  end
end
