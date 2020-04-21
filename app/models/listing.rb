class Listing < ApplicationRecord
  taggable_array :tags

  belongs_to :location
  has_many :matches, as: :receiver
  has_many :matches, as: :provider

  enum state: { received: 0, fulfilled: 1 }

  def name
    "#{type}: #{tags}"
  end
end
