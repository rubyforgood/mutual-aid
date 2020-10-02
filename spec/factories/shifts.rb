FactoryBot.define do
  factory :shift do
    person { nil }
    team { nil }
    started_at { "2020-05-18 14:25:55" }
    ended_at { "2020-05-18 14:25:55" }
    notes { "MyText" }
  end
end

# == Schema Information
#
# Table name: shifts
#
#  id         :bigint           not null, primary key
#  ended_at   :datetime
#  notes      :text
#  started_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :bigint           not null
#  team_id    :bigint           not null
#
# Indexes
#
#  index_shifts_on_person_id  (person_id)
#  index_shifts_on_team_id    (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_id => people.id)
#  fk_rails_...  (team_id => teams.id)
#
