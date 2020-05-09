class SaveListing < BaseInteractor
  record :service_area
  hash   :person, strip: false

  string :type
  string :description, default: nil
  string :title,       default: nil

  # todo: add other fields here and in nested interactors

  def execute
    merging_errors(in_transaction: true) do
      person_record = compose SavePerson, person
      Listing.create inputs.merge person: person_record
    end
  end

  def id; nil end # helps serialization
end
