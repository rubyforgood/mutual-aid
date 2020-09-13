class CommunityResource < ApplicationRecord
  extend Mobility
  translates :name, type: :string
  translates :description, type: :string

  acts_as_taggable_on :tags

  belongs_to :service_area, optional: true # TODO - should this be optional???
  belongs_to :location, optional: true
  belongs_to :organization, optional: true # TODO - should this be optional???

  has_many :matches_as_receiver
  has_many :matches_as_provider

  validates :name, presence: true

  accepts_nested_attributes_for :organization

  scope :pending_review, -> (){ where(is_approved: false) }

  def self.published
    now_strftime = Time.now.strftime("%Y-%m-%d %H:%M")

    where(is_approved: true).
        where("(publish_from IS NULL OR publish_from <= '#{ now_strftime }') AND
           (publish_until IS NULL OR '#{ now_strftime }' <= COALESCE(publish_until, now()) )")
  end

  def published?
    now = Time.now
    is_approved &&
    (publish_from.present? ? publish_from <= now : true) &&
      (publish_until == nil || now < publish_until)
  end

  def all_tags_unique
    all_tags_list.flatten.map(&:downcase).uniq
  end

  def all_tags_to_s
    all_tags_unique.join(", ")
  end
end

# == Schema Information
#
# Table name: community_resources
#
#  id                  :bigint           not null, primary key
#  description         :string
#  facebook_url        :string
#  is_approved         :boolean          default(TRUE), not null
#  is_created_by_admin :boolean          default(TRUE), not null
#  name                :string
#  phone               :string
#  publish_from        :date
#  publish_until       :date
#  tags                :string           default([]), is an Array
#  website_url         :string
#  youtube_identifier  :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  location_id         :bigint
#  organization_id     :bigint
#  service_area_id     :bigint
#
# Indexes
#
#  index_community_resources_on_is_approved          (is_approved)
#  index_community_resources_on_is_created_by_admin  (is_created_by_admin)
#  index_community_resources_on_location_id          (location_id)
#  index_community_resources_on_organization_id      (organization_id)
#  index_community_resources_on_service_area_id      (service_area_id)
#  index_community_resources_on_tags                 (tags) USING gin
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (service_area_id => service_areas.id)
#
