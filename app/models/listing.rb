class Listing < ApplicationRecord
  taggable_array :tags

  belongs_to :location

  enum state: { received: 0, fulfilled: 1 }
end
