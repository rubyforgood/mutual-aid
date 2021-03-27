# frozen_string_literal: true

class Announcement < ApplicationRecord
  extend Mobility
  translates :name, type: :string
  translates :description, type: :string

  acts_as_taggable_on :tags

  validates :name, :description, :publish_from, presence: true

  scope :approved, ->()       { where is_approved: true }
  scope :pending_review, ->() { where is_approved: false }

  def self.published
    before_now = DateTime.new..Time.current
    after_now  = Time.current..DateTime::Infinity.new

    approved
      .where(publish_from: before_now, publish_until: nil).or(
    approved
      .where(publish_from: before_now, publish_until: after_now)
    )
  end

  def published?
    now = Time.current
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
