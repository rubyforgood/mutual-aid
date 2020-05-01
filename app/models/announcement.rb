class Announcement < ApplicationRecord
  extend Mobility
  translates :name
  translates :description

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
