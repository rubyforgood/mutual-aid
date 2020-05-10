class Offer < Listing
  belongs_to :service_area, inverse_of: :offers

  scope :unmatched, ->() { includes(:matches_as_provider).references(:matches_as_provider).where("matches.receiver_id IS NULL") }

  def name
    all_tags_to_s
  end
end
