class LocationType < ApplicationRecord
  has_many :locations
  SERVICE_AREA_TYPE = "service_area"
end
