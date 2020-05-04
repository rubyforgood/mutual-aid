class CommunicationLog < ApplicationRecord
  belongs_to :person, optional: true
  belongs_to :match, optional: true

  DEFAULT_DELIVERY_STATUS = "completed"
end
