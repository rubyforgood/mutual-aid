FactoryBot.define do
  factory :position do
    association :person
    association :organization
  end
end

# == Schema Information
#
# Table name: positions
#
#  id                   :bigint           not null, primary key
#  description          :string
#  display_on_org_chart :boolean          default(TRUE), not null
#  end_date             :date
#  is_primary           :boolean          default(FALSE), not null
#  name                 :string
#  notes                :text
#  position_type        :string
#  start_date           :date
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  organization_id      :bigint
#  person_id            :bigint
#  team_id              :bigint
#
# Indexes
#
#  index_positions_on_organization_id  (organization_id)
#  index_positions_on_person_id        (person_id)
#  index_positions_on_team_id          (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (person_id => people.id)
#  fk_rails_...  (team_id => teams.id)
#
