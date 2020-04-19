class Organization < ApplicationRecord
  has_many :external_resources
  has_many :positions

  validates :name, presence: true

  def primary_contact
    positions.where(is_primary: true).last
  end
end
