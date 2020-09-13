class Team < ApplicationRecord
  belongs_to :organization

  has_many :positions

  scope :org_chart, -> { where(display_on_org_chart: true) }
end

# == Schema Information
#
# Table name: teams
#
#  id                        :bigint           not null, primary key
#  description               :string
#  display_on_org_chart      :boolean          default(TRUE), not null
#  name                      :string
#  standing_meeting_schedule :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  organization_id           :bigint           not null
#
# Indexes
#
#  index_teams_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
