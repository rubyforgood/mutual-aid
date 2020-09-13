class Location < ApplicationRecord
  belongs_to :location_type

  has_many :community_resources
  has_many :listings
  has_many :matches
  has_many :organizations
  has_many :people
  has_many :service_areas

  scope :city, ->(city){ where(city: city.to_s) }
  scope :location_type_name, ->(location_type_name){ joins(:location_type).where("location_types.name = ?", location_type_name.to_s) }
  scope :person_id, ->(person_id){ where(person_id: person_id.to_i) }
  scope :service_area_name, ->(service_area_name){ includes(listings: { service_area: :mobility_string_translations }).
      references(listings: { service_area: :mobility_string_translations }).
      where("mobility_string_translations.value = ?", service_area_name.to_s)
  }
  scope :street_address, ->(street_address){ where(street_address: street_address.to_s) }

  def name
    "#{ address }#{ " (" + location_type&.name + ")" if location_type }"
  end

  def address
    "#{ street_address }#{ ", " + city if city }#{ " " + state if state }"
  end
end

# == Schema Information
#
# Table name: locations
#
#  id               :bigint           not null, primary key
#  city             :string
#  county           :string
#  neighborhood     :string
#  region           :string
#  state            :string(2)
#  street_address   :string
#  zip              :string(5)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  location_type_id :bigint           not null
#
# Indexes
#
#  index_locations_on_location_type_id  (location_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_type_id => location_types.id)
#
