class Position < ApplicationRecord
  belongs_to :organization
  belongs_to :person, optional: true
  belongs_to :team, optional: true

  ASK_FORM_CONTACT_TITLE = "ASK_FORM_CONTACT"
  OFFER_FORM_CONTACT_TITLE = "OFFER_FORM_CONTACT"
  COMMUNITY_RESOURCES_CONTACT_TITLE = "COMMUNITY_RESOURCES_CONTACT"
  FORM_CONTACT_TITLES = [ASK_FORM_CONTACT_TITLE, OFFER_FORM_CONTACT_TITLE,
                         COMMUNITY_RESOURCES_CONTACT_TITLE, "Point of contact", "Member"]

  scope :yearbook_year, ->(yearbook_year) { where("start_date >= ? AND end_date <= ?",
                                                  yearbook_year || Time.zone.now.beginning_of_year,
                                                  yearbook_year || Time.zone.now.end_of_year) }

  def name
    "#{person.name + ", " if person.present?}#{position_type}"
  end
end
