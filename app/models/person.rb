class Person < ApplicationRecord
  acts_as_taggable_on :tags

  belongs_to :user, optional: true, inverse_of: :person
  belongs_to :service_area, optional: true
  belongs_to :location, optional: true
  belongs_to :preferred_contact_method, class_name: 'ContactMethod', foreign_key: :preferred_contact_method_id, inverse_of: :people

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

  accepts_nested_attributes_for :location

  validate :preferred_contact_method_present!

  # FIXME: extract into an interactor
  def self.create_from_peer_to_peer_params!(current_user, name:, preferred_contact_method_id:, contact_info:)
    contact_method = ContactMethod.find(preferred_contact_method_id)
    person_params = { name: name,
                      preferred_contact_method: contact_method,
                      user: current_user }

    contact_method_name = contact_method.name == "Email" ? :email : :phone
    person_params[contact_method_name] = contact_info

    create!(person_params)
  end

  def name_and_email
    "#{name} (#{email})"
  end

  def preferred_contact_info
    public_send(preferred_contact_method.field)
  end

  def profile_photo(fest_code)
    "missing.png"
  end

  def match_history
    "#{asks.matched.length} out of #{asks.length} Asks matched, and, #{offers.matched.length} out of #{offers.length} Offers matched"
  end

  def all_tags_unique
    all_tags_list.flatten.map(&:downcase).uniq
  end

  def all_tags_to_s
    all_tags_unique.join(", ")
  end

  def ask_tag_list
    asks.any? ? asks&.map(&:all_tags_unique) : []
  end

  def offer_tag_list
    offers.any? ? offers&.map(&:all_tags_unique) : []
  end

  def anonymized_name_and_email
    "#{Anonymize.name(name)} #{Anonymize.email(email)}"
  end

  private def preferred_contact_method_present!
    return unless preferred_contact_method
    field = preferred_contact_method.field
    errors.add(field, :blank) if self[field].blank?
  end
end

# == Schema Information
#
# Table name: people
#
#  id                          :bigint           not null, primary key
#  email                       :string
#  email_2                     :string
#  monthly_donation_amount_max :float            default(0.0)
#  monthly_matches_max         :integer          default(0)
#  name                        :string
#  notes                       :text
#  phone                       :string
#  phone_2                     :string
#  preferred_contact_timeframe :string
#  preferred_locale            :string           default("en"), not null
#  skills                      :text
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  location_id                 :bigint
#  preferred_contact_method_id :integer
#  service_area_id             :bigint
#  user_id                     :bigint
#
# Indexes
#
#  index_people_on_location_id      (location_id)
#  index_people_on_service_area_id  (service_area_id)
#  index_people_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#  fk_rails_...  (service_area_id => service_areas.id)
#  fk_rails_...  (user_id => users.id)
#
