class SystemLocation < ApplicationRecord
  belongs_to :parent, class_name: "SystemLocation", inverse_of: :system_locations, optional: true
  belongs_to :organization, optional: true

  has_many :system_locations, inverse_of: :parent

  def address
    "#{street_address}#{", " + city if city}#{" " + state if state}"
  end

  def name
    "#{ parent.name.upcase + ": " if parent}#{parent ? parent.address : address }#{ " (" + location_type + ")" if location_type}"
  end
end
