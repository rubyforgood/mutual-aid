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
