FactoryBot.define do
  factory :contact_method do
    name    { 'Call' }
    field   { 'phone' }
    enabled { true }
  end
end
