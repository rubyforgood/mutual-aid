FactoryBot.define do
  factory :software_feedback do
    association :created_by
    feedback_type { "MyString" }
    module_name { "MyString" }
    page_url { "MyString" }
    name { "MyString" }
    urgency { "MyString" }
    urgency_order { 1 }
    notes { "MyString" }
    completed { false }
    completed_at { "2020-05-08 15:40:10" }
  end
end
