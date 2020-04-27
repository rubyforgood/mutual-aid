class Position < ApplicationRecord
  belongs_to :organization
  belongs_to :person

end
