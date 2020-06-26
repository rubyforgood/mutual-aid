class Offer < Listing
  belongs_to :service_area, inverse_of: :offers

  scope :matched, ->() { includes(:matches_as_provider).references(:matches_as_provider).where.not(matches: {receiver_id: nil}) }
  scope :unmatched, ->() { includes(:matches_as_provider).references(:matches_as_provider).where(matches: {receiver_id: nil}) }
  scope :matchable, ->() { where(id: unmatched.pluck(:id) + inexhaustible.pluck(:id)) }
end
