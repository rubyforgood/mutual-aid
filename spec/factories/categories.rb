FactoryBot.define do
  factory :category do
    name { "MyString" }
    parent { nil }
    description { "MyText" }
    display_to_public { false }
    display_order { 1 }
    is_created_by_admin { false }
  end
end
