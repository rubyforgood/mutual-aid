class SystemLocation < ApplicationRecord
  belongs_to :parent, class_name: "SystemLocation", inverse_of: :system_locations
  belongs_to :organization

  has_many :system_locations, inverse_of: :parent
end
