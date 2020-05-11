class CommunityResource < ApplicationRecord
  extend Mobility
  translates :name
  translates :description, type: :text

  acts_as_taggable_on :tags

  belongs_to :service_area, optional: true # TODO - should this be optional???
  belongs_to :location, optional: true
  belongs_to :organization, optional: true # TODO - should this be optional???

  has_many :matches_as_receiver
  has_many :matches_as_provider

  validates :name, presence: true

  accepts_nested_attributes_for :organization

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
