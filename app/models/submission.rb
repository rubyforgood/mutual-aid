class Submission < ApplicationRecord
  belongs_to :person
  belongs_to :service_area

  def moderation_requested?
    privacy_level_requested == "moderation_requested"
  end
end
