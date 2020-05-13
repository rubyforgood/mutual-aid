class Submission < ApplicationRecord
  belongs_to :person
  belongs_to :service_area

  has_many :submission_responses

  def moderation_requested?
    privacy_level_requested == "moderation_requested"
  end

  def category_list
    ["transportation", "groceries"]
  end

  def urgency
    "I can wait a week"
  end
end
