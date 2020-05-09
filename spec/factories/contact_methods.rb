FactoryBot.define do
  factory :contact_method, aliases: [:contact_method_call] do
    name    { 'Call' }
    field   { 'phone' }
    enabled { true }

    factory :contact_method_text do
      name  { 'Text' }
      field { 'phone' }
    end

    factory :contact_method_email do
      name  { 'Email' }
      field { 'email' }
    end
  end
end
