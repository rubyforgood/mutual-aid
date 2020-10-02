FactoryBot.define do
  factory :history_log do
    topic { "MyString" }
    name { "MyString" }
  end
end

# == Schema Information
#
# Table name: history_logs
#
#  id         :bigint           not null, primary key
#  name       :string
#  topic      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
