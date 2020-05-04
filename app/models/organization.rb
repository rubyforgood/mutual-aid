class Organization < ApplicationRecord
  belongs_to :location, optional: true
  belongs_to :service_area, optional: true

  has_many :community_resources
  has_many :positions

  validates :name, presence: true

  def self.current_organization
    self.where(is_instance_owner: first).first
  end

  def primary_contact
    positions.find_by(is_primary: true)
  end

  def ask_form_contact
    positions.where(position_type: Position::ASK_FORM_CONTACT_TITLE, organization: Organization.current_organization).first
  end

  def offer_form_contact
    positions.where(position_type: Position::OFFER_FORM_CONTACT_TITLE, organization: Organization.current_organization).first
  end

  def community_resources_contact
    positions.where(position_type: Position::COMMUNITY_RESOURCES_CONTACT_TITLE, organization: Organization.current_organization).first
  end
end
