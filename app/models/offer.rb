class Offer < Listing
  belongs_to :provider, class_name: "Person", foreign_key: "person_id"
  belongs_to :service_area, inverse_of: :offers

  scope :unmatched, ->() { where(receiver_id: nil) }

  def name
    tags.flatten.join(", ")
  end
end
