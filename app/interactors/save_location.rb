class SaveLocation < BaseInteractor
  record :location_type
  integer :id,             default: nil
  string  :street_address, default: nil
  string  :neighborhood,   default: nil
  string  :city,           default: nil
  string  :state,          default: nil
  string  :zip,            default: nil
  string  :county,         default: nil
  string  :region,         default: nil

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
