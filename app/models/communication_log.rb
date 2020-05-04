class CommunicationLog < ApplicationRecord
  belongs_to :person, optional: true
  belongs_to :match, optional: true
  belongs_to :created_by, optional: true, class_name: "User", foreign_key: "created_by_id"

  DEFAULT_DELIVERY_STATUS = "completed"
  AUTO_DELIVERY_CHANNEL = "autoemail"
  DELIVERY_CHANNELS = [AUTO_DELIVERY_CHANNEL, "email", "text", "call", "snailmail"]
end
