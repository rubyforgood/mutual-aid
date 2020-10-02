class SoftwareFeedback < ApplicationRecord
  belongs_to :created_by, optional: true, class_name: "User", foreign_key: :created_by_id

  FEEDBACK_TYPES = ["new feature", "change", "bug"]
  MODULE_NAMES = [
    "ask form", "offer form", "contributions page" ] + [
      "admin",
      "system settings",
      "community resources module",
      "announcements module",
      "donations module",
      "positions module",
      "shared accounts module",
      "yearbook"
    ].sort
  URGENCIES = ["critical", "anytime", "blue sky"]
end

# == Schema Information
#
# Table name: software_feedbacks
#
#  id            :bigint           not null, primary key
#  completed     :boolean          default(FALSE), not null
#  completed_at  :datetime
#  feedback_type :string
#  module_name   :string
#  name          :string           not null
#  notes         :string
#  page_url      :string
#  urgency       :string
#  urgency_order :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  created_by_id :bigint
#
# Indexes
#
#  index_software_feedbacks_on_completed      (completed)
#  index_software_feedbacks_on_created_by_id  (created_by_id)
#
