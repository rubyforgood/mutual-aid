class ListingForm < Reform::Form
  collection :tags

  property :location, form: LocationForm
end
