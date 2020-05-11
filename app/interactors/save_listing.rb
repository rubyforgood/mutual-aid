class SaveListing < BaseInteractor
  string :type
  string :description, default: nil
  string :title,       default: nil
  array  :tags,        default: []

  hash   :person, strip: false
  record :service_area

  def execute
    merging_errors(in_transaction: true) do
      # TODO: save location to listing as well
      person_record = compose SavePerson, person
      Listing.create inputs.merge person: person_record
    end
  end

  def id; nil end # helps serialization
end
