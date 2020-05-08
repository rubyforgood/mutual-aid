class Donation < ApplicationRecord
  belongs_to :person, optional: true

  has_many :matches, as: :receiver
  has_many :matches, as: :provider

  scope :this_month, -> { where("created_at >= ? AND created_at <= ?",
                                Time.zone.now.beginning_of_month, Time.zone.now.end_of_month) }
end
