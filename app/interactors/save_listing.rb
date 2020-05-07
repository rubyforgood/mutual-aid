class SaveListing < BaseInteractor
  record :service_area
  string :type

  hash :person, strip: false

  # todo: add other fields here and in nested interactors

  def execute
    merging_errors(in_transaction: true) do
      person_record = compose SavePerson, person
      Listing.create inputs.merge person: person_record
    end
  end
end
