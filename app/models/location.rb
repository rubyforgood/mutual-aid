class Location < ApplicationRecord
  belongs_to :service_area

  has_many :community_resources
  has_many :listings
  has_many :matches
  has_many :organizations
  has_many :people

  def address
    "#{street_address}#{", " + city if city}#{" " + state if state}"
  end

  def full_name
    "#{ parent.name.upcase + ": " if parent}#{name}#{ " (" + location_type + ")" if location_type}"
  end
end
