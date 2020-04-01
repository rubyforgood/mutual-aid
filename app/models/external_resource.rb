class ExternalResource < ApplicationRecord
  taggable_array :tags

  belongs_to :location, optional: true
end
