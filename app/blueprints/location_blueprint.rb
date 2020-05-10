class LocationBlueprint < Blueprinter::Base
  identifier :id

  fields :street_address, :neighborhood, :city, :state, :zip, :county, :region
end
