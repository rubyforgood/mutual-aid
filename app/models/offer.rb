class Offer < Listing
  belongs_to :service_area, inverse_of: :offers

  scope :matched, ->() { includes(:matches_as_provider).references(:matches_as_provider).where("matches.receiver_id IS NOT NULL") }
  scope :unmatched, ->() { includes(:matches_as_provider).references(:matches_as_provider).where("matches.receiver_id IS NULL") }

  def icon_class
    "fa fa-hand-sparkles"
  end
end
