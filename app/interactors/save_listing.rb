class SaveListing < BaseInteractor
  record :service_area
  hash   :person, strip: false

<<<<<<< HEAD
  string :type
  array  :tag_list,    default: []
  string :description, default: nil
  string :title,       default: nil
=======
  hash :person, strip: false
  hash :location, strip: false
>>>>>>> 81f88c4... WIP: Random changes to update assns between LocationType, Location, ServiceArea, Listing

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
