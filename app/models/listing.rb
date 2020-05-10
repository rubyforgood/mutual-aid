class Listing < ApplicationRecord
  extend Mobility

  acts_as_taggable_on :tags

  translates :title
  translates :description, type: :text

  belongs_to :person
  belongs_to :service_area
  belongs_to :location, optional: true

  has_many :matches
  has_many :matches_as_receiver, class_name: "Match", foreign_key: "receiver_id"
  has_many :matches_as_provider, class_name: "Match", foreign_key: "provider_id"

  validates :type, presence: true

  enum state: { received: 0, fulfilled: 1 }

  def self.all_tags_unique(collection)
    collection ||= all
    collection.map(&:all_tags_unique).flatten.uniq
  end

  def name
    "#{type}: #{all_tags_to_s}"
  end

  def all_tags_unique
    all_tags_list.flatten.map(&:downcase).uniq
  end

  def all_tags_to_s
    all_tags_unique.join(", ")
  end
end
