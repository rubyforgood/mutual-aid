class Position < ApplicationRecord
  belongs_to :organization
  belongs_to :person, optional: true
  belongs_to :team, optional: true

  ASK_FORM_CONTACT_TITLE = "ASK_FORM_CONTACT"
  OFFER_FORM_CONTACT_TITLE = "OFFER_FORM_CONTACT"
  COMMUNITY_RESOURCES_CONTACT_TITLE = "COMMUNITY_RESOURCES_CONTACT"
  FORM_CONTACT_TITLES = [ASK_FORM_CONTACT_TITLE, OFFER_FORM_CONTACT_TITLE,
                         COMMUNITY_RESOURCES_CONTACT_TITLE, "Point of contact", "Member"]

  scope :org_chart, -> { where(display_on_org_chart: true) }
  scope :yearbook_year, ->(yearbook_year) { where("start_date >= ? AND end_date <= ?",
                                                  yearbook_year || Time.zone.now.beginning_of_year,
                                                  yearbook_year || Time.zone.now.end_of_year) }

  def name
    (person.present? ? "#{person.name}, " : '') + position_type.to_s
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
