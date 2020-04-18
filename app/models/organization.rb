class Organization < ApplicationRecord
  belongs_to :point_of_contact, optional: true

  validates :name, presence: true
end
