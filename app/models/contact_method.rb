class ContactMethod < ApplicationRecord
  scope :enabled, -> { where enabled: true }
end
