class CommunicationLog < ApplicationRecord
  belongs_to :delivery_method, class_name: "ContactMethod", foreign_key: "delivery_method_id"
  belongs_to :person, optional: true
  belongs_to :match, optional: true
  belongs_to :created_by, optional: true, class_name: "User", foreign_key: "created_by_id"

  DEFAULT_DELIVERY_STATUS = "autoemail completed"
  DELIVERY_STATUSES = [DEFAULT_DELIVERY_STATUS, "left voicemail", "no answer", "busy signal", "sent"]

  def self.log_submission_email(email_object, delivery_status, submission, delivery_method=nil, current_user=nil)
    delivery_method ||= ContactMethod.autoemail(true).last
    self.create!(delivery_method: delivery_method,
                 delivery_status: delivery_status,
                 person: submission.person,
                 sent_at: Time.now,
                 subject: email_object.subject,
                 body: email_object.html_part&.body || email_object.body.raw_source,
                 created_by: current_user
    )
  end

  def name
    "#{delivery_method}: #{subject} #{created_at.strftime("%A, %B %d, %Y at %l:%M %P")}"
  end

end
