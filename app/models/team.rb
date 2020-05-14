class Team < ApplicationRecord
  belongs_to :organization

  has_many :positions
end
