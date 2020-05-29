class Submission < ApplicationRecord
  acts_as_taggable_on :tags

  belongs_to :person
  belongs_to :service_area

  has_many :listings
  has_many :submission_responses

  accepts_nested_attributes_for :listings, :person

  PRIVACY_LEVELS = ["anyone", "users", "volunteers", "dispatchers only"]

  def moderation_requested?
    privacy_level_requested == "moderation_requested"
  end

  def name
    "#{created_at.strftime("%m-%d-%Y")}: #{person.name}. [#{all_tags_list}] (#{service_area.name})"
  end

  def category_list
    all_tags_list #["transportation", "groceries"]
  end

  def urgency
    "I can wait a week"
  end

  def name
    "(#{created_at.strftime("%m-%d-%Y")}) #{form_name.titleize} - #{service_area.name}"
  end

end
