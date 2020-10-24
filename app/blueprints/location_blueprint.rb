# frozen_string_literal: true

class LocationBlueprint < Blueprinter::Base
  identifier :id

  fields :street_address, :neighborhood, :city, :state, :zip, :county, :region

  view :with_location_type do
    association :location_type, blueprint: LocationTypeBlueprint
  end
end
