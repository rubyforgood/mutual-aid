FactoryBot.define do
  factory :user, aliases: [:created_by] do # TODO: implement admin via Pundit
    email { Faker::Internet.email }
    password { 'minimal_password' }
    confirmed_at { Time.zone.today }

    trait :admin do
      role { :admin }
	  end

    trait :neighbor do
      role { :neighbor }
    end

    trait :volunteer do
      role { :volunteer }
    end

    trait :dispatcher do
      role { :dispatcher }
    end

    trait :sys_admin do
      role { :sys_admin }
    end

    trait :with_person do
      after(:create) do |instance, evaluated|
        create(:person, user: instance)
      end
    end
  end
end
