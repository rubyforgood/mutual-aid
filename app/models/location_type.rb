class LocationType < ApplicationRecord
  has_many :locations
  SERVICE_AREA_TYPE = "service_area"

  scope :visible, -> { where(display_to_public: true) }
end
