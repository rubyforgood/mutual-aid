FactoryBot.define do
  factory :location do
    location_type { "MyString" }
    street_address { "MyString" }
    city { "MyString" }
    state { "NY" }
    zip { "12345" }
    county { "MyString" }
  end
end
