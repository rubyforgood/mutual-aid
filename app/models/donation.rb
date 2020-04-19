class Donation < ApplicationRecord
  belongs_to :person, optional: true

  has_many :matches, as: :matchable_asker
  has_many :matches, as: :matchable_offerer
end
