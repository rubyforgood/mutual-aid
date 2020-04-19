class SystemLocation < ApplicationRecord
  belongs_to :parent, class_name: "SystemLocation", inverse_of: :system_locations, optional: true
  belongs_to :organization, optional: true

  has_many :system_locations, inverse_of: :parent
end
