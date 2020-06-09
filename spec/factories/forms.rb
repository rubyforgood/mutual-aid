FactoryBot.define do
  factory :form do
    contribution_type_name { "MyString" }
    name { "MyString" }
    header_html { "MyString" }
    footer_html { "MyString" }
    display_categories { false }
    organization { nil }
  end
end
