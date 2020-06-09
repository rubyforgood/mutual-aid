class Ask < Listing
  belongs_to :service_area, inverse_of: :asks

  scope :matched, ->() { includes(:matches_as_receiver).references(:matches_as_receiver).where.not(matches: {provider_id: nil}) }
  scope :unmatched, ->() { includes(:matches_as_receiver).references(:matches_as_receiver).where(matches: {provider_id: nil}) }
end
