FactoryBot.define do
  factory :system_locale do
    locale { "MyString" }
    locale_name { "MyString" }
    publish_in_dropdowns { false }
    publish_translations { false }
  end
end
