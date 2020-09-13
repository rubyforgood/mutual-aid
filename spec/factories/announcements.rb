FactoryBot.define do
  factory :announcement, aliases: [:translatable] do
    name { "MyString" }
  end
end

# == Schema Information
#
# Table name: announcements
#
#  id            :bigint           not null, primary key
#  description   :text
#  is_approved   :boolean          default(FALSE), not null
#  name          :string
#  publish_from  :date
#  publish_until :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
