class ServiceArea < ApplicationRecord
  extend Mobility
  translates :name, type: :string
  translates :description, type: :string

  belongs_to :location, class_name: "Location", inverse_of: :service_areas, foreign_key: :location_id
  belongs_to :organization
  belongs_to :parent, class_name: "ServiceArea", inverse_of: :service_areas, optional: true

  has_many :mobility_string_translations, inverse_of: :translatable, class_name: "MobilityStringTranslation", foreign_key: :translatable_id

  has_many :asks, class_name: "Ask", foreign_key: "service_area_id", inverse_of: :service_area
  has_many :offers, class_name: "Offer", foreign_key: "service_area_id", inverse_of: :service_area
  has_many :listings
  has_many :people
  has_many :service_areas, inverse_of: :parent

  TYPES = %w[pod neighborhood region county city other]

  validates :name, presence: true
  validates :service_area_type, presence: true

  accepts_nested_attributes_for :location

  scope :order_by_translated_name, -> (locale=:en){
    includes(:mobility_string_translations).references(:mobility_string_translations).
    where("mobility_string_translations.locale = ?", locale.to_s).
    where("mobility_string_translations.key = ?", 'name').
    order(MobilityStringTranslation.arel_table["value"].lower.asc)
  }

  scope :translated_name, ->(name) { joins(:mobility_string_translations).
      where("mobility_string_translations.key = 'name' AND mobility_string_translations.locale = 'en'").
      where("LOWER(mobility_string_translations.value) = ?", name) }

  scope :as_filter_types, -> { i18n.select :id, :name }
  scope :publicly_visible, -> { where(display_to_public: true) }

  def full_name
    "#{ parent.name.upcase + ": " if parent}#{name}#{ " (" + service_area_type + ")" if service_area_type}"
  end
end
