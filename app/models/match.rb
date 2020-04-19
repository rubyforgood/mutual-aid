class Match < ApplicationRecord
  belongs_to :asker, class_name: "Listing", foreign_key: :asker_id, inverse_of: :matches_as_asker
  belongs_to :owner, class_name: "Listing", foreign_key: :owner_id, inverse_of: :matches_as_owner # note, this will need to be expanded to accept Person, ExternalResource, tec
end
