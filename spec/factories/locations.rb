FactoryBot.define do
  factory :location do
    location_type { "MyString" }
    description { "MyString" }
    street_address { "MyString" }
    city { "MyString" }
    state { "NY" }
    zip { "12345" }
    county { "MyString" }
    facebook_url { "MyString" }
    website_url { "MyString" }
    phone { "MyString" }
  end
end
