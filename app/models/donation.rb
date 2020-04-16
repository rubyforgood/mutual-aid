class Donation < ApplicationRecord
  belongs_to :person, optional: true
end
