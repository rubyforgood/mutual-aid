FactoryBot.define do
  factory :system_tag do
    name { "MyString" }
    description { "MyString" }
    display_to_public { false }
    display_order { 1 }
    parent { nil }
    created_by { "MyString" }
  end
end
