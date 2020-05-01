class Offer < Listing
  belongs_to :person, inverse_of: :offers_as_provider
  belongs_to :service_area, inverse_of: :offers
end
