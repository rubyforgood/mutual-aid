class Ask < Listing
  belongs_to :service_area, inverse_of: :asks

  scope :unmatched, ->() { includes(:matches_as_receiver).references(:matches_as_receiver).where("matches.provider_id IS NULL") }
  scope :matched, ->() { includes(:matches_as_receiver).references(:matches_as_receiver).where("matches.provider_id IS NOT NULL") }

  def icon_class
    "fa fa-hand-holding-heart"
  end
end
