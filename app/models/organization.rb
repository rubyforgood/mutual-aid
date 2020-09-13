class Organization < ApplicationRecord
  belongs_to :location, optional: true
  belongs_to :service_area, optional: true

  has_many :community_resources
  has_many :positions
  has_many :teams

  validates :name, presence: true

  # TODO: rename to instance_owner?
  scope :current_organization, -> { find_by(is_instance_owner: true) }
  scope :org_chart, -> { where(display_on_org_chart: true) }

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

# == Schema Information
#
# Table name: organizations
#
#  id                   :bigint           not null, primary key
#  description          :string
#  display_on_org_chart :boolean          default(TRUE), not null
#  facebook_url         :string
#  favicon_url          :string
#  has_hosting_account  :boolean          default(FALSE), not null
#  has_mailer_account   :boolean          default(FALSE), not null
#  has_sms_account      :boolean          default(FALSE), not null
#  is_instance_owner    :boolean          default(TRUE), not null
#  logo_url             :string
#  name                 :string
#  phone                :string
#  short_name           :string
#  website_url          :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  location_id          :bigint
#  service_area_id      :bigint
#
# Indexes
#
#  index_organizations_on_location_id      (location_id)
#  index_organizations_on_service_area_id  (service_area_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#  fk_rails_...  (service_area_id => service_areas.id)
#
