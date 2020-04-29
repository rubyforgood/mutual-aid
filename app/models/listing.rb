class Listing < ApplicationRecord
  taggable_array :tags
  extend Mobility
  translates :title
  translates :description, type: :text

  belongs_to :location, optional: true
  belongs_to :service_area, optional: true

  has_many :matches, as: :receiver
  has_many :matches, as: :provider

  enum state: { received: 0, fulfilled: 1 }

  def name
    "#{type}: #{tags}"
  end
end
