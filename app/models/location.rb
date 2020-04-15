class Location < ApplicationRecord
  belongs_to :parent, optional: true, class_name: "Location", inverse_of: :locations
  has_many :locations, as: :parent, class_name: "Location", foreign_key: :parent_id, inverse_of: :parent
  has_many :points_of_contact, class_name: "Position"
  has_many :external_resources

  def address
    "#{street_address}#{", " + city if city}#{" " + state if state}"
  end

  def full_name
    "#{ parent.name.upcase + ": " if parent}#{parent ? name : name&.upcase }#{ " (" + location_type + ")" if location_type}"
  end

  def primary_contact
    points_of_contact.where(is_primary: true).last
  end
end
