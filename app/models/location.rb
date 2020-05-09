class Location < ApplicationRecord
  belongs_to :locationable, polymorphic: true

  has_many :community_resources
  has_many :listings
  has_many :matches
  has_many :organizations
  has_many :people

  # validates :location_type, presence: true # TODO - add this back in later?

  def name
    "#{ address }#{ " (" + location_type + ")" if location_type }"
  end

  def address
    "#{ street_address }#{ ", " + city if city }#{ " " + state if state }"
  end
end
