class Person < ApplicationRecord
  acts_as_taggable_on :tags

  belongs_to :user, optional: true, inverse_of: :person
  belongs_to :service_area, optional: true
  belongs_to :location, optional: true
  belongs_to :preferred_contact_method, class_name: 'ContactMethod'

  has_many :asks, inverse_of: :person
  has_many :offers, inverse_of: :person
  has_many :listings
  has_many :matches, through: :listings
  has_many :matches_as_receiver, through: :asks, class_name: "Match", foreign_key: "receiver_id"
  has_many :matches_as_provider, through: :offers, class_name: "Match", foreign_key: "provider_id"

  has_many :communication_logs
  has_many :donations
  has_many :positions
  has_many :submissions

  validate :preferred_contact_method_present!

  def name_and_email
    "#{name} (#{email})"
  end

  def profile_photo(fest_code)
    "missing.png"
  end

  def all_tags_unique
    all_tags_list.flatten.map(&:downcase).uniq
  end

  def all_tags_to_s
    all_tags_unique.join(", ")
  end

  def temporary_ask_tag_list # these will be directly on the person once forms are available
    asks.any? ? Listing.all_tags_unique(asks) : temporary_offer_tag_list + ["translation"]
  end

  def temporary_offer_tag_list # these will be directly on the person once forms are available
    offers.any? ? Listing.all_tags_unique(offers) : ["transportation", "meals"]
  end

  private def preferred_contact_method_present!
    return unless preferred_contact_method
    field = preferred_contact_method.field
    errors.add(field, :blank) if self[field].blank?
  end
end
