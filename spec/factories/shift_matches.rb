FactoryBot.define do
  factory :shift_match do
    association :shift
    association :match
    notes { "MyString" }
  end
end

# == Schema Information
#
# Table name: shift_matches
#
#  id         :bigint           not null, primary key
#  notes      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  match_id   :bigint           not null
#  shift_id   :bigint           not null
#
# Indexes
#
#  index_shift_matches_on_match_id  (match_id)
#  index_shift_matches_on_shift_id  (shift_id)
#
# Foreign Keys
#
#  fk_rails_...  (match_id => matches.id)
#  fk_rails_...  (shift_id => shifts.id)
#
