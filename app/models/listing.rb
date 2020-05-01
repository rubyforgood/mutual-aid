class Listing < ApplicationRecord
  taggable_array :tags
  extend Mobility
  translates :title
  translates :description, type: :text

  belongs_to :person
  belongs_to :person_as_provider, class_name: "Person", foreign_key: "person_id"
  belongs_to :person_as_receiver, class_name: "Person", foreign_key: "person_id"
  belongs_to :service_area
  belongs_to :location, optional: true

  has_many :matches, as: :receiver
  has_many :matches, as: :provider

  enum state: { received: 0, fulfilled: 1 }

  def name
    "#{type}: #{tags}"
  end
end
