FactoryBot.define do
  factory :submission_response do
    submission { nil }
    custom_form_question { nil }
    boolean_response { false }
    date_response { "2020-05-12" }
    datetime_response { "2020-05-12 23:13:57" }
    integer_response { 1 }
    text_response { "MyText" }
    string_response { "MyString" }
    array_response { "" }
  end
end
