class SavePerson < ActiveInteraction::Base
  integer :id, default: nil
  string :preferred_contact_method  # todo: string?
  string :email

  hash :location, strip: false

  def execute
    ensure_location_id_provided_if_existing_person!

    Person.transaction do
      location_record = compose SaveLocation, location
      person_params = inputs.merge location: location_record

      person = id? ?
        Person.update(id, person_params) :
        Person.create(person_params)

      unless person.valid?
        errors.merge! person.errors
        raise ActiveRecord::Rollback
      end

      person
    end
  end

  private

    def ensure_location_id_provided_if_existing_person!
      fail 'Missing location.id param attempting to update existing person' if id? && location[:id].blank?
    end
end
