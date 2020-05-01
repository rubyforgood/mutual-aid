class Person < ApplicationRecord
  belongs_to :user, optional: true, inverse_of: :person
  belongs_to :service_area, optional: true
  belongs_to :location, optional: true

  has_many :asks_as_receiver, class_name: "Listing::Ask", foreign_key: "person_id", inverse_of: :person
  has_many :offers_as_provider, class_name: "Listing::Offer", foreign_key: "person_id", inverse_of: :person
  has_many :listings

  has_many :matches, as: :receiver
  has_many :matches, as: :provider

  validate :validate_phone_or_email

  def name
    "#{first_name} #{last_name} (#{email})"
  end

  private def validate_phone_or_email
    if !(phone.present? || email.present?)
      errors.add(:participant, " --  email or phone needed")
    end
  end
end
