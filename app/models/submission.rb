class Submission < ApplicationRecord
  acts_as_taggable_on :tags

  belongs_to :person
  belongs_to :service_area

  has_many :listings
  has_many :submission_responses

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
    "I can wait a week [TBD]"
  end

  def self.create_from_listing_and_log!(listing, current_user)
    where_params = {
        person: listing.person,
        service_area: listing.service_area,
        form_name: "#{listing.type.downcase}_form",
        # privacy_level_requested: ?, # TODO - implement privacy_level_options
        created_at: listing.created_at
    }
    create_params = { body: listing.attributes, current_user: current_user }
    submission = where(where_params).first
    unless submission
      self.create!(where_params.merge create_params)
    end
    submission.email_confirmation_and_log(current_user)
    submission
  end

end
