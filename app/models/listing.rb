class Listing < ApplicationRecord
  taggable_array :tags

  belongs_to :location
  has_many :matches, as: :matchable_asker
  has_many :matches, as: :matchable_offerer

  enum state: { received: 0, fulfilled: 1 }

  def name
    "#{type}: #{tags}"
  end
end
