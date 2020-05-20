FactoryBot.define do
  factory :mobility_string_translation do
    association :translatable # stubbing this out to Announcement only rn, but it is polymorphic
    locale { "MyString" }
    key { "MyString" }
    value { "MyString" }
    created_by { nil }
    is_approved { false }
  end
end
