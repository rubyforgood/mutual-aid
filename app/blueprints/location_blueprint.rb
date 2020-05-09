class LocationBlueprint < Blueprinter::Base
  identifier :id

  fields :street_address, :neighborhood, :city, :state, :zip, :county, :region

  view :normal do
    association :location_type, blueprint: LocationTypeBlueprint
  end
end
