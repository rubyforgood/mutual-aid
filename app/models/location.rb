class Location < ApplicationRecord

  has_many :community_resources
  has_many :listings
  has_many :matches
  has_many :organizations
  has_many :people

  validates :location_type, presence: true

  def address
    "#{street_address}#{", " + city if city}#{" " + state if state}"
  end

  def full_name
    "#{ parent.name.upcase + ": " if parent}#{name}#{ " (" + location_type + ")" if location_type}"
  end
end
