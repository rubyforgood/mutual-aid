class CommunicationLog < ApplicationRecord
  belongs_to :delivery_method, class_name: "ContactMethod", foreign_key: "delivery_method_id"
  belongs_to :person, optional: true
  belongs_to :match, optional: true
  belongs_to :created_by, optional: true, class_name: "User", foreign_key: "created_by_id"

  scope :needs_follow_up, ->(boolean=nil){ where(needs_follow_up: boolean || true) }

  def self.log_email(email:, delivery_status:, person:, initiator: nil)
    create!(
      delivery_method: ContactMethod.email,
      delivery_status: delivery_status,
      person: person,
      sent_at: Time.current,
      subject: email.subject,
      body: email.html_part&.body || email.body.raw_source,
      created_by: initiator,
      auto_generated: true,
    )
  end

  def name
    "#{delivery_method&.name}: #{subject} #{created_at.strftime("%A, %B %d, %Y at %l:%M %P")}"
  end

end

# == Schema Information
#
# Table name: communication_logs
#
#  id                 :bigint           not null, primary key
#  auto_generated     :boolean          default(FALSE)
#  body               :string
#  delivery_status    :string
#  needs_follow_up    :boolean          default(FALSE), not null
#  outbound           :boolean          default(TRUE), not null
#  sent_at            :datetime
#  subject            :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  created_by_id      :bigint           default(1), not null
#  delivery_method_id :bigint           not null
#  match_id           :bigint
#  person_id          :bigint
#
# Indexes
#
#  index_communication_logs_on_created_by_id       (created_by_id)
#  index_communication_logs_on_delivery_method_id  (delivery_method_id)
#  index_communication_logs_on_match_id            (match_id)
#  index_communication_logs_on_person_id           (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (match_id => matches.id)
#  fk_rails_...  (person_id => people.id)
#
