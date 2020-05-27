FactoryBot.define do
  factory :user, aliases: [:admin, :created_by] do # TODO: implement admin via Pundit
    email { Faker::Internet.email }
    password { 'minimal_password' }
    confirmed_at { Time.zone.today }
  end
end
