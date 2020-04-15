FactoryBot.define do
  factory :location do
    name { "MyString" }
    parent { nil }
    location_type { "MyString" }
    description { "MyString" }
    street_address { "MyString" }
    city { "MyString" }
    state { "MyString" }
    zip { "MyString" }
    county { "MyString" }
    facebook_url { "MyString" }
    website_url { "MyString" }
    phone { "MyString" }
  end
end
