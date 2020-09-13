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
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string           default("unset")
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role                  (role)
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
