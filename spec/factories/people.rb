FactoryBot.define do
  factory :person do
    user
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
  end
end
