class Person < ApplicationRecord
  belongs_to :user, optional: true, inverse_of: :person
  belongs_to :service_area, optional: true
  belongs_to :location, optional: true

  has_many :communication_logs

  has_many :asks, inverse_of: :person
  has_many :offers, inverse_of: :person
  has_many :listings

  has_many :communication_logs
  has_many :listings
  has_many :matches
  has_many :matches_as_receiver, class_name: "Match", foreign_key: "receiver_id"
  has_many :matches_as_provider, class_name: "Match", foreign_key: "provider_id"

  validates :preferred_contact_method, presence: true
  validate :validate_preferred_contact_method_data

  PHONE_CONTACT_METHODS = ["call", "text"]
  PREFERRED_CONTACT_METHODS = PHONE_CONTACT_METHODS + ["email"]

  def name
    "#{first_name} #{last_name} (#{email})"
  end

  def temporary_ask_tag_list # these will be directly on the person once forms are available
    asks.any? ? asks.map(&:tags).flatten.uniq : temporary_offer_tag_list + ["translation"]
  end

  def temporary_offer_tag_list # these will be directly on the person once forms are available
    offers.any? ? offers.map(&:tags).flatten.uniq : ["transportation", "meals"]
  end

  private def validate_preferred_contact_method_data
    preferred_contact_data = PHONE_CONTACT_METHODS.include?(preferred_contact_method) ? "phone" : preferred_contact_method
    if preferred_contact_method.present? && !self.public_send(preferred_contact_data).present?
      errors.add(:person, " -- #{preferred_contact_method} needed (preferred contact method)")
    end
  end
end
