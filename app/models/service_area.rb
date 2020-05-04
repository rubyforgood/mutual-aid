class ServiceArea < ApplicationRecord
  extend Mobility
  translates :name
  translates :description, type: :text

  belongs_to :parent, class_name: "ServiceArea", inverse_of: :service_areas, optional: true
  belongs_to :organization, optional: true

  has_many :asks, class_name: "Ask", foreign_key: "service_area_id", inverse_of: :service_area
  has_many :offers, class_name: "Offer", foreign_key: "service_area_id", inverse_of: :service_area
  has_many :listings
  has_many :people
  has_many :service_areas, inverse_of: :parent

  validates :name, presence: true

  def full_name
    "#{ parent.name.upcase + ": " if parent}#{name}#{ " (" + service_area_type + ")" if service_area_type}"
  end
end
