FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { 'minimal_password' }
    confirmed_at { Date.today }
  end
end
