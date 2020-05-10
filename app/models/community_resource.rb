class CommunityResource < ApplicationRecord
  extend Mobility
  translates :name
  translates :description, type: :text

  acts_as_taggable_on :tags

  belongs_to :service_area, optional: true # TODO - should this be optional???
  belongs_to :location, optional: true
  belongs_to :organization, optional: true # TODO - should this be optional???

  has_many :matches, as: :receiver
  has_many :matches, as: :provider

  validates :name, presence: true

  def self.published
    now_strftime = Time.now.strftime("%Y-%m-%d %H:%M")

    where(is_approved: true).
        where("(publish_from IS NOT NULL AND publish_from <= '#{ now_strftime }') AND
           (publish_until IS NULL OR '#{ now_strftime }' <= COALESCE(publish_until, now()) )")
  end

  def published?
    now = Time.now
    is_approved &&
    (publish_from.present? ? publish_from <= now : true) &&
      (publish_until == nil || now < publish_until)
  end

end
