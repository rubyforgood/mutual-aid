class Listing < ApplicationRecord
  taggable_array :tags

  belongs_to :location
  has_many :matches_as_asker
  has_many :matches_as_owner

  enum state: { received: 0, fulfilled: 1 }

  def name
    "#{type}: #{tags}"
  end
end
