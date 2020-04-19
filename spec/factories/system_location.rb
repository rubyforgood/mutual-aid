FactoryBot.define do
  factory :system_location do
    street_address { "MyString" }
    city { "MyString" }
    state { "NY" }
    zip { "12345" }
  end
end
