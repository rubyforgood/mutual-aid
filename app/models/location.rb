class Location < ApplicationRecord
  has_many :external_resources

  def address
    "#{street_address}#{", " + city if city}#{" " + state if state}"
  end
end
