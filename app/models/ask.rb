class Ask < Listing
  belongs_to :person, inverse_of: :asks_as_receiver
  belongs_to :service_area, inverse_of: :asks
end
