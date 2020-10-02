class Announcement < ApplicationRecord
  extend Mobility
  translates :name, type: :string
  translates :description, type: :string

  acts_as_taggable_on :tags

  scope :pending_review, -> (){ where(is_approved: false) }

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

  def all_tags_unique
    all_tags_list.flatten.map(&:downcase).uniq
  end
end

# == Schema Information
#
# Table name: announcements
#
#  id            :bigint           not null, primary key
#  description   :text
#  is_approved   :boolean          default(FALSE), not null
#  name          :string
#  publish_from  :date
#  publish_until :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
