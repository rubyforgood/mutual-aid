FactoryBot.define do
  factory :user, aliases: [:admin] do # TODO: implement admin via Pundit
    email { Faker::Internet.email }
    password { 'minimal_password' }
    confirmed_at { Date.today }
  end
end
