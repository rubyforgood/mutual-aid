class CommunicationLog < ApplicationRecord
  belongs_to :person, optional: true
  belongs_to :match, optional: true
  belongs_to :created_by, optional: true, class_name: "User", foreign_key: "created_by_id"

  DEFAULT_DELIVERY_STATUS = "completed"

  AUTO_DELIVERY_CHANNEL = "autoemail"
  DELIVERY_CHANNELS = [AUTO_DELIVERY_CHANNEL, "email", "text", "call", "snailmail"]

  def self.log_submission_email(email_object, delivery_status, submission, delivery_channel=nil, current_user=nil)
    delivery_channel ||= AUTO_DELIVERY_CHANNEL
    self.create!(delivery_channel: delivery_channel,
                 delivery_status: delivery_status,
                 person: submission.person,
                 sent_at: Time.now,
                 subject: email_object.subject,
                 body: email_object.html_part&.body || email_object.body.raw_source,
                 created_by: current_user
    )
  end

  def name
    "#{delivery_channel}: #{subject} #{created_at.strftime("%A, %B %d, %Y at %l:%M %P")}"
  end
end
