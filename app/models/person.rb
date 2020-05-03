class Person < ApplicationRecord
  belongs_to :user, optional: true, inverse_of: :person
  belongs_to :service_area, optional: true
  belongs_to :location, optional: true

  has_many :asks, inverse_of: :person
  has_many :offers, inverse_of: :person
  has_many :listings

  has_many :matches, as: :receiver
  has_many :matches, as: :provider

  validates :preferred_contact_method, presence: true
  validate :validate_preferred_contact_method_data

  def name
    "#{first_name} #{last_name} (#{email})"
  end

  private def validate_preferred_contact_method_data
    if preferred_contact_method.present? && !self.public_send(preferred_contact_method).present?
      errors.add(:participant, " -- #{preferred_contact_method} needed (preferred contact method)")
    end
  end
end
