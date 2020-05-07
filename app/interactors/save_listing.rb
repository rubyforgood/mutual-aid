class SaveListing < ActiveInteraction::Base
  record :service_area
  string :type

  hash :person, strip: false

  # todo: add other fields here and in nested interactors

  def execute
    Listing.transaction do
      person_record = compose SavePerson, person

      listing = Listing.create inputs.merge person: person_record

      unless listing.valid?
        errors.merge! listing.errors
        raise ActiveRecord::Rollback
      end

      listing
    end
  end
end
