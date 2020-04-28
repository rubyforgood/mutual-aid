class Donation < ApplicationRecord
  belongs_to :person, optional: true

  has_many :matches, as: :receiver
  has_many :matches, as: :provider
end
