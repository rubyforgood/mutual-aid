class SaveLocation < BaseInteractor
<<<<<<< HEAD
  integer :id,             default: nil
  string  :street_address, default: nil
  string  :neighborhood,   default: nil
  string  :city,           default: nil
  string  :state,          default: nil
  string  :zip,            default: nil
  string  :county,         default: nil
  string  :region,         default: nil

  # TODO: add `type` field
=======
  integer :id, default: nil
  record :location_type
>>>>>>> 81f88c4... WIP: Random changes to update assns between LocationType, Location, ServiceArea, Listing

  def execute
    merging_errors do
      location_type_record = compose SaveLocationType, location_type
      location_params = inputs.merge location_type: location_type_record

      if id?
        Location.update(id, location_params)
      else
        Location.create(location_params)
      end
    end
  end
end
