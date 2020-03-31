class Listing < ApplicationRecord
  taggable_array :tags

  enum state: { received: 0, fulfilled: 1 }
end
