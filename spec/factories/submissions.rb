FactoryBot.define do
  factory :submission do
    association :person
    association :service_area
    form_name { "ask_form" }
    body { "Hash of form params" }
  end
end
