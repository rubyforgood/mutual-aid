class Position < ApplicationRecord
  belongs_to :organization
  belongs_to :person, optional: true

  ASK_FORM_CONTACT_TITLE = "ASK_FORM_CONTACT"
  OFFER_FORM_CONTACT_TITLE = "OFFER_FORM_CONTACT"
  COMMUNITY_RESOURCES_CONTACT_TITLE = "COMMUNITY_RESOURCES_CONTACT"
  FORM_CONTACT_TITLES = [ASK_FORM_CONTACT_TITLE, OFFER_FORM_CONTACT_TITLE,
                         COMMUNITY_RESOURCES_CONTACT_TITLE, "Point of contact", "Member"]

  def name
    "#{person.name + ", " if person.present?}#{position_type}"
  end
end
