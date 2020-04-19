class Person < ApplicationRecord
  belongs_to :user, inverse_of: :person

  has_many :matches, as: :matchable_asker
  has_many :matches, as: :matchable_offerer
end
