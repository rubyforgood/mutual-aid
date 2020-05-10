# TODO: Remove this when we replace listings_controller actions with offer/ask controller actions
class ListingForm < Reform::Form
  collection :tags
  property :location, form: LocationForm
end
