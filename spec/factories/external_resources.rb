FactoryBot.define do
  factory :external_resource do
    name { "MyString" }
    website_url { "MyString" }
    facebook_url { "MyString" }
    phone { "MyString" }
    description { "MyString" }
    display_on_website { false }
    youtube_identifier { "MyString" }
    location { nil }
  end
end
