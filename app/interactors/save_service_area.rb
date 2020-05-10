class SaveServiceArea < BaseInteractor
  integer :id, default: nil

  record :location, strip: false

  def execute
    merging_errors do
      location_record = compose SaveLocation, location
      service_area_params = inputs.merge location: location_record

      if id?
        ServiceArea.update(id, service_area_params)
      else
        ServiceArea.create(service_area_params)
      end
    end
  end
end
