class Match < ApplicationRecord
  belongs_to :owner, class_name: "Listing"
  belongs_to :asker, class_name: "Listing"
end
