FactoryBot.define do
  factory :match do

    association :provider
    association :receiver

    trait :with_ask_and_offer do
      association :provider, factory: :offer
      association :receiver, factory: :ask
    end

  end
end

# == Schema Information
#
# Table name: matches
#
#  id            :bigint           not null, primary key
#  completed     :boolean          default(FALSE), not null
#  exchanged_at  :datetime
#  notes         :string
#  provider_type :string
#  receiver_type :string
#  status        :string
#  tentative     :boolean          default(TRUE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  provider_id   :integer
#  receiver_id   :integer
#
