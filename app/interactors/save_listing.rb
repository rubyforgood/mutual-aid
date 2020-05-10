class SaveListing < BaseInteractor
  record :service_area
  string :type
  string :description, default: nil
  string :title,       default: nil
  array  :tag_list,    default: []

  hash :person, strip: false
  hash :location, strip: false

  # todo: add other fields here and in nested interactors

  def execute
    merging_errors(in_transaction: true) do
      location_record = compose SaveLocation, location
      person_record = compose SavePerson, person
      Listing.create inputs.merge person: person_record, location: location_record
    end
  end

  def id; nil end # helps serialization
end
