class Match < ApplicationRecord
  belongs_to :matchable_asker, polymorphic: true
  belongs_to :matchable_offerer, polymorphic: true
end
