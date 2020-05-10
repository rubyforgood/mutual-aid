class Location < ApplicationRecord
  belongs_to :location_type

  has_many :community_resources
  has_many :listings
  has_many :matches
  has_many :organizations
  has_many :people
  has_many :service_areas

  def name
    "#{ address }#{ " (" + location_type&.name + ")" if location_type }"
  end

  def address
    "#{ street_address }#{ ", " + city if city }#{ " " + state if state }"
  end
end
